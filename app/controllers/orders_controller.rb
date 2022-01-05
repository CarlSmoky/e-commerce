class OrdersController < ApplicationController

  def show
    # SELECT  "orders".* FROM "orders" WHERE "orders"."id" = $1 LIMIT 1  [["id", 1]]
    #<Order id: 1, total_cents: 2500, created_at: "2022-01-04 23:57:34", updated_at: "2022-01-04 23:57:34", stripe_charge_id: "ch_3KEMskL1gojLHJyB0mzyjRrB", email: "kvirani@gmail.com">
    @order = Order.find(params[:id])
    
    # SELECT "line_items".* FROM "line_items" WHERE "line_items"."order_id" = $1  [["order_id", 1]]
    #<Order id: 1, total_cents: 2500, created_at: "2022-01-04 23:57:34", updated_at: "2022-01-04 23:57:34", stripe_charge_id: "ch_3KEMskL1gojLHJyB0mzyjRrB", email: "kvirani@gmail.com">
    @line_items = @order.line_items
    
    # SELECT  "products".* FROM "products" WHERE "products"."id" = $1 LIMIT 1  [["id", 4]]
    #<Product id: 4, name: "Hipster Socks", description: "Diy food truck twee letterpress photo booth biodie...", image: "apparel4.jpg", price_cents: 2500, quantity: 8, created_at: "2022-01-04 23:37:51", updated_at: "2022-01-04 23:37:51", category_id: 1>
    @products = @line_items.map {|line_item| Product.find(line_item.product_id)}
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end

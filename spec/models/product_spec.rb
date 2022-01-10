require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # @category = Category.create
  # @product = Product.new(name: "name", price: 1000, quantity: 10, category_id: @category.ids)
  # @product.save

  describe 'Validations' do
    it "is valid with name" do
      @category = Category.create(name: "Cap")
      @product = Product.create( name: "Takekoptor", price: 1000, quantity: 10, category_id: @category.id)
      expect(@product.name).to be_present
    end

    it "should name is null" do
      @category = Category.create(name: "Cap")
      @product = Product.create( price: 1000, quantity: 10, category_id: @category.id)
      expect(@product.name).to be_nil
    end

    it "is valid with price" do
      @category = Category.create(name: "Cap")
      @product = Product.new(name: "Takekoptor", price: 1000, quantity: 10, category_id: @category.id)
      expect(@product.price).to be_present
    end

    it "should price is null" do
      @category = Category.create(name: "Cap")
      @product = Product.new(name: "Takekoptor", quantity: 10, category_id: @category.id)
      expect(@product.price).to be_nil
    end

    it "is valid with quantity" do
      @category = Category.create(name: "Shooes")
      @product = Product.new(name: "Spiky sandals", price: 1000, quantity: 10, category_id: @category.id)
      
      expect(@product.quantity).to be_present
    end

    it "is valid with category" do
      @category = Category.create(name: "Cap")
      @product = Product.create(name: "Spiky sandals", price: 1000, quantity: 10, category_id: @category.id)
      puts @product.errors.full_messages
      expect(@product.category).to be_present
    end

    it "is valid with category" do
      @category = Category.create(name: "Cap")
      @product = Product.create()
      puts @product.errors.full_messages
      expect(@product.category).to be_nil
    end

  end
end

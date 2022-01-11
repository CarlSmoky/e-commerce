require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # pending "add some scenarios (or delete) #{__FILE__}"
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      # @category.products.create!(
      #   name:  Faker::Hipster.sentence(3),
      #   description: Faker::Hipster.paragraph(4),
      #   quantity: 10,
      #   price: 64.99
      # )
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end
  end

 

  scenario "They see all products" do
    # ACT
    visit root_path
    click_on "Add", match: :first
    # find_button('Add').first.click

    # DEBUG / VERIFY
    save_screenshot
    puts page.html

    

    expect(page).to have_text 'My Cart (1)'
  end
end

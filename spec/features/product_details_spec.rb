require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js:true do
  before :each do
    @category = Category.create! name: 'Apparel'
    10.times do |n|
      @pro = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 200000.99
      )
    end
  end
  scenario "They see product's details" do
  visit root_path
  first('article.product').find_link("#{@pro.name}").click
  # first('article.product').find_link("#{Details}").click
  sleep(2)
  save_screenshot 'testing_ProductDetails.png'
  expect(page).to have_css 'article.product-detail'
  end
end

require 'rails_helper'
RSpec.feature "AddToCarts", type: :feature, js:true do
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
  scenario "Cart is being updated" do
  visit root_path
  first('article.product').find_link('Add').click
  # sleep(2)
  save_screenshot 'testing-add-to-cart.png'
  within("#navbar") { expect(page).to have_content('My Cart (1)') }
  # within('#navbar') { expect(page).to have_text 'My Cart (1)' }
  end
end

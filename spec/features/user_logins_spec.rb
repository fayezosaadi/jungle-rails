require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js:true do
  before :each do
    @user = User.create!(
      first_name: 'First User',
      last_name: 'Last name',
      email: 'first@user.com',
      password: '123456',
      password_confirmation: '123456'
    )
end
  scenario "They can login" do
    visit '/sessions/new'
    
    within 'form' do
      fill_in id: 'email', with: 'first@user.com'
      fill_in id: 'password', with: '123456'
      
      click_button 'submit'
    end
    save_screenshot 'user_login.png'
    within("#navbar") { expect(page).to have_content('Log out') }
  end
end



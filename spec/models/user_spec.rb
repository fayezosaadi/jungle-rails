require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:all) do
    @user10 = User.new(first_name: 'fa', last_name: 'O', email: 'fay@gmail.com', password: '1234', password_confirmation: '1234' )
    @user11 = User.new(first_name: 'fa', last_name: 'O', email: 'fay@gmail.com', password: '1234', password_confirmation: '1234' )
    @user12 = User.new(first_name: 'fa', last_name: 'O', email: 'f@gmail.com', password: '12', password_confirmation: '12' )
    end
  
    it 'should have a first name' do
      @user = User.new
      @user.first_name = 'Fayez'
      @user.validate
      expect(@user.errors[:first_name]).to_not include("can't be blank")
    end
    it 'gives an error if it does not have a first name' do
      @user = User.new
      @user.validate
      expect(@user.errors[:first_name]).to include("can't be blank")
    end
    it 'should have a last name' do
      @user = User.new
      @user.last_name = 'OF'
      @user.validate
      expect(@user.errors[:last_name]).to_not include("can't be blank")
    end
    it 'gives an error if it does not have a last name' do
      @user = User.new
      @user.validate
      expect(@user.errors[:last_name]).to include("can't be blank")
    end
    it 'should have a unique Email' do
      @user10.save  
      @user11.save
      expect(@user11).to_not(be_valid)
    end
    it 'a password and password_confirmation should match' do
      expect(@user10).to(be_valid)
    end
    it 'gives an error if password and password_confirmation does not match' do
      @user10.password_confirmation = '124'
      expect(@user10).to_not(be_valid)
    end
    it 'password should have minimum length of 3 characters' do
      expect(@user12).to_not(be_valid)
    end 
  end

  describe '.authenticate_with_credentials' do
    before(:all) do
      @user13 = User.new(first_name: 'fayez', last_name: 'O', email: 'fay@gmail.com', password: '123', password_confirmation: '123' )
      @user14 = User.new(first_name: 'fayez', last_name: 'O', email: 'test@gmail.com', password: '123', password_confirmation: '123' )
      @user15 = User.new(first_name: 'fayez', last_name: 'O', email: 'test2@gmail.com', password: '123', password_confirmation: '123' )
    end
    
    it 'should authenticate user13' do
      @user13.save
      @user_auth = User.authenticate_with_credentials('fay@gmail.com','123')
      expect(@user_auth).to eq @user13
    end
    
    it 'should return nil if no authontication' do
      @user13.save
      @user_auth = User.authenticate_with_credentials('fay@gmail.com','1234')
      expect(@user_auth).to eq nil
    end
    
    it 'should authenticate user14 even with spaces before and/or after their email ' do
      @user14.save
      @user_auth = User.authenticate_with_credentials('test@gmail.com ','123')
      expect(@user_auth).to eq @user14
    end
    
    it 'should authenticate user15, email case insensitive ' do
      @user15.save
      @user_auth = User.authenticate_with_credentials('TeST2@gmail.com ','123')
      expect(@user_auth).to eq @user15
    end
  end
end

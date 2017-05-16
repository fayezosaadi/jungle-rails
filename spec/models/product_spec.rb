require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'should have a name' do
      @product = Product.new
      @product.name = 'F12'
      @product.validate
      expect(@product.errors[:name]).to_not include("can't be blank")
    end

    it 'gives an error if it does not have a name' do
      @product = Product.new
      @product.validate
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'should have a price' do
      @product = Product.new
      @product.price = 2
      @product.validate
      expect(@product.errors[:price]).to_not include("is not a number", "can't be blank")
    end

    it 'gives an error if it does not have a price' do
      @product = Product.new
      @product.validate
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it 'should have a quantity' do
      @product = Product.new
      @product.quantity = 2
      @product.validate
      expect(@product.errors[:quantity]).to_not include("can't be blank")
    end

    it 'gives an error if it does not have a quantity' do
      @product = Product.new
      @product.validate
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it 'should have a category' do
      @product = Product.new
      @product.category = Category.create(name: 'a')
      @product.validate
      expect(@product.errors[:category]).to_not include("can't be blank")
    end

    it 'gives an error if it does not have a category' do
      @product = Product.new
      @product.validate
      expect(@product.errors[:category]).to include("can't be blank")
    end
  end
end

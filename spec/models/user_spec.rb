require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    it "is valid with all data" do
      @user = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      expect(@user).to be_present
    end

    it "is null if missing first_name" do
      @user = User.create(last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts @user.errors.full_messages
      expect(@user.first_name).to be_nil
    end

    it "is null if missing last_name" do
      @user = User.create(first_name: "Jeff", email: "k@r.example.com", password: "password", password_confirmation: "password")
      expect(@user.last_name).to be_nil
    end

    it "is valid if missing email" do
      @user = User.create(first_name: "Noran", last_name: "Mobila", password: "password", password_confirmation: "password")
      expect(@user.email).to be_nil
    end

    it "is null if missing password" do
      @user = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "", password_confirmation: "uso")
      expect(@user.password).to be_nil
    end

    it "is null if missing password_confirmation" do
      @user = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password")
      expect(@user.password_confirmation).to be_nil
    end

  end

  describe '.authenticate_with_credentials' do
    it "is authenticate with the valid email and password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials("k@r.example.com", "password")
      
      expect(user).to be_present
    end

    it "is authenticate with the valid email and invalid password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials("k@r.example.com", "uso")
      
      expect(user).to be_nil
    end

    it "is authenticate with the invalid email and password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials("j@r.example.com", "password")
      
      expect(user).to be_nil
    end

    it "is authenticate with the valid email with space and password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials(" k@r.example.com ", "password")
      
      expect(user).to be_present
    end

    it "is authenticate with the valid email with uppercase and password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials("K@r.exaMple.coM", "password")
      expect(user).to be_present
    end

    it "is authenticate with the valid email with space uppercase and password" do
      user1 = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "password")
      puts user1
      puts user1.errors.full_messages
      user =User.authenticate_with_credentials(" k@r.examPle.coM ", "password")
      expect(user).to be_present
    end
  end
end

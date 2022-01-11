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
    it "is null if password doesn't match" do
      @user = User.create(first_name: "Noran", last_name: "Mobila", email: "k@r.example.com", password: "password", password_confirmation: "uso")
      puts @user
      expect(@user).to be_nil
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a username, password, and confirm_password' do
    user = User.new(
      username: 'testuser',
      password: 'password',
      confirm_password: 'password'
    )
    expect(user).to be_valid
  end

  it 'is invalid without a username' do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it 'is invalid without a password' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid without a confirm_password' do
    user = User.new(confirm_password: nil)
    user.valid?
    expect(user.errors[:confirm_password]).to include("can't be blank")
  end

  it 'is invalid when password and confirm_password do not match' do
    user = User.new(
      password: 'password',
      confirm_password: 'wrong_password'
    )
    user.valid?
    expect(user.errors[:confirm_password]).to include("doesn't match Password")
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a first name, last name, email, and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  it 'is invalid without a first name' do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include('can\'t be blank')
  end
  it 'is invalid without a last name' do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include('can\'t be blank')
  end

  it 'is invalid without an email address' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('can\'t be blank')
  end

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'test@mail.com')
    user = FactoryBot.build(:user, email: 'test@mail.com')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'returns a user\'s full name as a string' do
    user = FactoryBot.build(:user, first_name: 'Pavlo', last_name: 'Kasianchuk')
    expect(user.name).to eq 'Pavlo Kasianchuk'
  end

  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'check factory create different emails' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(user1).to_not eql(user2)
    expect(true).to be true
  end
end

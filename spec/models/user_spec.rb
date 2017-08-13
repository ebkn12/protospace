require 'rails_helper'

describe User do
  describe '#create' do
    it 'is valid with a name, email, password, avatar, profile, position, occupation' do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end

    it 'is valid without an avatar' do
      user = build(:user, avatar: nil)
      user.valid?
      expect(user).to be_valid
    end

    it 'is valid without a profile' do
      user = build(:user, profile: nil)
      user.valid?
      expect(user).to be_valid
    end

    it 'is valid without a position' do
      user = build(:user, position: nil)
      user.valid?
      expect(user).to be_valid
    end

    it 'is valid without an occupation' do
      user = build(:user, occupation: nil)
      user.valid?
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'is invalid without a email' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'is invalid with a duplicate name' do
      create(:user, name: 'Jyn Erso')
      user = build(:user, name: 'Jyn Erso')
      user.valid?
      expect(user.errors[:name]).to include('はすでに存在します')
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'test@test.com')
      user = build(:user, email: 'test@test.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'returns only related prototypes' do
      user = create(:user, name: 'anakin', email: 'test@test.com')
      other_user = create(:user, name: 'obiwan', email: 'test2@test.com')
      prototype1 = create(:prototype, user_id: user.id)
      prototype2 = create(:prototype, user_id: user.id)
      prototype3 = create(:prototype, user_id: other_user.id)
      # expect(user.related_prototypes(1)).to eq[prototype2, prototype1]
      # expect(user.related_prototypes(1)).not_to include(prototype3)
    end
  end
end

require 'rails_helper'

describe User do
  describe '#create' do
    context 'with valid attributes' do
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
    end

    context 'with invalid attributes' do
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

      it 'is invalid without a password_confirmation although with a password' do
        user = build(:user, password_confirmation: '')
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とPasswordの入力が一致しません')
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

      it 'is invalid with a password that has less than 5 characters' do
        user = build(:user, password: 'vador', password_confirmation: 'vador')
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end
    end
  end

  describe 'associations' do
    let(:user) {
      create(
        :user,
        name: Faker::StarWars.character,
        email: Faker::Internet.email
      )
    }

    it 'delete prototype when related user is deleted' do
      create(:prototype, user_id: user.id)
      expect { user.destroy }.to change { Prototype.count }.by(-1)
    end

    it 'delete comment when related user is deleted' do
      create(:comment, user_id: user.id)
      expect { user.destroy }.to change { Comment.count }.by(-1)
    end

    it 'delete like when related user is deleted' do
      create(:like, user_id: user.id)
      expect { user.destroy }.to change { Like.count }.by(-1)
    end
  end

  describe '#related_prototypes' do
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

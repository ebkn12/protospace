require 'rails_helper'

describe Like do
  describe '#create' do
    context 'with valid attributes' do
      it 'is valid with user_id and prototype_id' do
        user = create(:user,
          name: Faker::StarWars.character,
          email: Faker::Internet.email
        )
        prototype = create(:prototype)
        like = build(:like, user_id: user.id, prototype_id: prototype.id)
        like.valid?
        expect(like).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without user_id' do
        like = build(:like, user_id: nil)
        like.valid?
        expect(like.errors[:user_id]).to include('を入力してください')
      end

      it 'is invalid without prototype_id' do
        like = build(:like, prototype_id: nil)
        like.valid?
        expect(like.errors[:prototype_id]).to include('を入力してください')
      end
    end
  end
end

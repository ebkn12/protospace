require 'rails_helper'

describe Comment do
  describe '#create' do
    let(:user) {
      create(
        :user,
        name: Faker::StarWars.character,
        email: Faker::Internet.email
      )
    }
    let(:prototype) { create(:prototype) }

    context 'with valid attributes' do
      it 'is valid with a content, user_id, prototype_id' do
        comment = build(:comment, user_id: user.id, prototype_id: prototype.id)
        comment.valid?
        expect(comment).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a content' do
        comment = build(:comment, content: nil, user_id: user.id, prototype_id: prototype.id)
        comment.valid?
        expect(comment.errors[:content]).to include('を入力してください')
      end

      it 'is invalid without an user_id' do
        comment = build(:comment, user_id: nil, prototype_id: prototype.id)
        comment.valid?
        expect(comment.errors[:user_id]).to include('を入力してください')
      end

      it 'is invalid without a prototype_id' do
        comment = build(:comment, user_id: user.id, prototype_id: nil)
        comment.valid?
        expect(comment.errors[:prototype_id]).to include('を入力してください')
      end
    end
  end
end

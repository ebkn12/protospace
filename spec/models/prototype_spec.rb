require 'rails_helper'

describe Prototype do
  describe '#create' do
    context 'with valid attributes' do
      it 'is valid with a title, catch_copy, concept, user_id' do
        prototype = build(:prototype)
        prototype.valid?
        expect(prototype).to be_valid
      end

      it 'is valid without a catch_copy' do
        prototype = build(:prototype, catch_copy: nil)
        prototype.valid?
        expect(prototype).to be_valid
      end

      it 'is valid without a concept' do
        prototype = build(:prototype, concept: nil)
        prototype.valid?
        expect(prototype).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a title' do
        prototype = build(:prototype, title: nil)
        prototype.valid?
        expect(prototype.errors[:title]).to include('を入力してください')
      end

      it 'is invalid without an user_id' do
        prototype = build(:prototype, user_id: nil)
        prototype.valid?
        expect(prototype.errors[:user_id]).to include('を入力してください')
      end
    end
  end

  describe 'associations' do
    before do
      @user = create(:user,
        name: Faker::StarWars.character,
        email: Faker::Internet.email
      )
      @prototype = create(:prototype)
    end

    it 'delete comment when related prototype is deleted' do
      create(:comment, user_id: @user.id, prototype_id: @prototype.id)
      expect { @prototype.destroy }.to change { Comment.count }.by(-1)
    end

    it 'delete like when related prototype is deleted' do
      create(:like, user_id: @user.id, prototype_id: @prototype.id)
      expect { @prototype.destroy }.to change { Like.count }.by(-1)
    end

    it 'delete captured_images when related prototype is deleted' do
      create(:captured_image, prototype_id: @prototype.id, status: 1)
      create(:captured_image, prototype_id: @prototype.id, status: 0)
      expect { @prototype.destroy }.to change { CapturedImage.count }.by(-2)
    end
  end

  describe '#main_image' do
    it 'returns only main_image' do
      prototype = create(:prototype)
      image1 = create(:captured_image, status: 1, prototype_id: prototype.id)
      image2 = create(:captured_image, status: 0, prototype_id: prototype.id)
      expect(prototype.main_image).to eq image1
    end
  end

  describe '#sub_images' do
    it 'returns an array of sub_images' do
      prototype = create(:prototype)
      image1 = create(:captured_image, status: 1, prototype_id: prototype.id)
      image2 = create(:captured_image, status: 0, prototype_id: prototype.id)
      image3 = create(:captured_image, status: 0, prototype_id: prototype.id)
      expect(prototype.sub_images).to eq [image2, image3]
    end
  end
end

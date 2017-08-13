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

    context 'with instance method' do
      it 'returns only related main_image' do
        prototype = create(:prototype)
        image1 = create(:captured_image, status: 1, prototype_id: prototype.id)
        image2 = create(:captured_image, status: 0, prototype_id: prototype.id)
        expect(prototype.main_image).to eq image1
      end

      it 'returns related sub_images' do
        prototype = create(:prototype)
        image1 = create(:captured_image, status: 1, prototype_id: prototype.id)
        image2 = create(:captured_image, status: 0, prototype_id: prototype.id)
        image3 = create(:captured_image, status: 0, prototype_id: prototype.id)
        expect(prototype.sub_images).to eq [image2, image3]
      end
    end
  end
end

require 'rails_helper'

describe CapturedImage do
  describe '#create' do
    context 'with vald attributes' do
      it 'is valid with a content and prototype_id' do
        captured_image = build(:captured_image)
        captured_image.valid?
        expect(captured_image).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without a content' do
        captured_image = build(:captured_image, content: nil)
        captured_image.valid?
        expect(captured_image.errors[:content]).to include('を入力してください')
      end

      it 'is invalid without a status' do
        captured_image = build(:captured_image, status: nil)
        captured_image.valid?
        expect(captured_image.errors[:status]).to include('を入力してください')
      end
    end
  end
end

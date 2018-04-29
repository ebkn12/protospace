require 'rails_helper'

describe CapturedImage, type: :model do
  let!(:prototype) { create(:prototype) }
  let(:content) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'prototype.jpg'), 'image/jpeg') }
  let(:status) { 0 }
  let(:captured_image) { build(:captured_image, prototype: prototype, content: content, status: status) }

  context 'when valid' do
    before { captured_image.valid? }
    it { expect(captured_image).to be_valid }
  end
  context 'when invalid' do
    before { captured_image.valid? }
    context 'when content is nil' do
      let(:content) { nil }
      it { expect(captured_image).not_to be_valid }
      it { expect(captured_image.errors[:content]).to include('を入力してください') }
    end
    context 'when status is nil' do
      let(:status) { nil }
      it { expect(captured_image).not_to be_valid }
      it { expect(captured_image.errors[:status]).to include('を入力してください') }
    end
    context 'when prototype is nil' do
      let(:prototype) { nil }
      it { expect(captured_image).not_to be_valid }
      it { expect(captured_image.errors[:prototype]).to include('を入力してください') }
    end
    context 'when specified prototype is invalid' do
      let(:captured_image) { build(:captured_image, prototype_id: 10, content: content, status: status) }
      it { expect(captured_image).not_to be_valid }
      it { expect(captured_image.errors[:prototype]).to include('を入力してください') }
    end
  end
end

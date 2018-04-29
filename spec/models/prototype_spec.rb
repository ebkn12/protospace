require 'rails_helper'

describe Prototype, type: :model do
  describe 'validation' do
    let!(:user) { create(:user) }
    let(:title) { 'プロトタイプテスト' }
    let(:catch_copy) { 'キャッチコピーテスト' }
    let(:concept) { 'コンセプトテスト' }
    let(:prototype) { build(:prototype, user: user, title: title, catch_copy: catch_copy, concept: concept) }

    context 'when valid' do
      before { prototype.valid? }
      it { expect(prototype).to be_valid }
      context 'when catch_copy is nil' do
        let(:catch_copy) { nil }
        it { expect(prototype).to be_valid }
      end
      context 'when concept is nil' do
        let(:concept) { nil }
        it { expect(prototype).to be_valid }
      end
    end
    context 'when invalid' do
      before { prototype.valid? }
      context 'when title is nil' do
        let(:title) { nil }
        it { expect(prototype).not_to be_valid }
        it { expect(prototype.errors[:title]).to include('を入力してください') }
      end
      context 'when user is nil' do
        let(:user) { nil }
        it { expect(prototype).not_to be_valid }
        it { expect(prototype.errors[:user]).to include('を入力してください') }
      end
      context 'when specified user is invalid' do
        let(:prototype) { build(:prototype, user_id: 10, title: title, catch_copy: catch_copy, concept: concept) }
        it { expect(prototype).not_to be_valid }
        it { expect(prototype.errors[:user]).to include('を入力してください') }
      end
    end
  end

  describe 'dependent: :destroy option' do
    let!(:user) { create(:user) }
    let!(:prototype) { create(:prototype, user: user) }

    context 'when prototype deleted' do
      context 'with comment' do
        before { create(:comment, user: user, prototype: prototype) }
        it { expect { prototype.destroy }.to change { Comment.count }.by(-1) }
      end
      context 'with captured_images' do
        before { create(:captured_image, prototype: prototype) }
        it { expect { prototype.destroy }.to change { CapturedImage.count }.by(-1) }
      end
      context 'with like' do
        before { create(:like, user: user, prototype: prototype) }
        it { expect { prototype.destroy }.to change { Like.count }.by(-1) }
      end
    end
  end

  describe '#main_image' do
    let!(:user) { create(:user) }
    let!(:prototype) { create(:prototype, user: user) }
    let!(:main_image) { create(:captured_image, status: 1, prototype: prototype) }
    let!(:sub_image) { create(:captured_image, status: 0, prototype: prototype) }

    it { expect(prototype.main_image).to eq(main_image) }
  end

  describe '#sub_images' do
    let!(:user) { create(:user) }
    let!(:prototype) { create(:prototype, user: user) }
    let!(:main_image) { create(:captured_image, status: 1, prototype: prototype) }
    let!(:sub_image1) { create(:captured_image, status: 0, prototype: prototype) }
    let!(:sub_image2) { create(:captured_image, status: 0, prototype: prototype) }

    it { expect(prototype.sub_images).to contain_exactly(sub_image1, sub_image2) }
  end
end

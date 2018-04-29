require 'rails_helper'

describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:posting_user) { create(:user, name: '投稿者', email: 'post@test.com') }
  let!(:prototype) { create(:prototype, user: posting_user) }
  let(:content) { 'テストコメント' }
  let(:comment) { build(:comment, user: user, prototype: prototype, content: content) }

  context 'when valid' do
    before { comment.valid? }
    it { expect(comment).to be_valid }
  end
  context 'when invalid' do
    before { comment.valid? }
    context 'when content is nil' do
      let(:content) { nil }
      it { expect(comment).not_to be_valid }
      it { expect(comment.errors[:content]).to include('を入力してください') }
    end
    context 'when user is nil' do
      let(:user) { nil }
      it { expect(comment).not_to be_valid }
      it { expect(comment.errors[:user]).to include('を入力してください') }
    end
    context 'when specified user is not exist' do
      let(:comment) { build(:comment, user_id: 100, prototype: prototype, content: content) }
      it { expect(comment).not_to be_valid }
      it { expect(comment.errors[:user]).to include('を入力してください') }
    end
    context 'when prototype is nil' do
      let(:prototype) { nil }
      it { expect(comment).not_to be_valid }
      it { expect(comment.errors[:prototype]).to include('を入力してください') }
    end
    context 'when specified prototype is not exist' do
      let(:comment) { build(:comment, user: user, prototype_id: 100, content: content) }
      it { expect(comment).not_to be_valid }
      it { expect(comment.errors[:prototype]).to include('を入力してください') }
    end
  end
end

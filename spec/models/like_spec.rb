require 'rails_helper'

describe Like, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
  let!(:prototype) { create(:prototype, user: other_user) }
  let(:like) { build(:like, user: user, prototype: prototype) }

  context 'when valid' do
    before { like.valid? }
    it { expect(like).to be_valid }
  end
  context 'when invalid' do
    before { like.valid? }
    context 'when user is nil' do
      let(:user) { nil }
      it { expect(like).not_to be_valid }
    end
    context 'when prototype is nil' do
      let(:prototype) { nil }
      it { expect(like).not_to be_valid }
    end
  end
end

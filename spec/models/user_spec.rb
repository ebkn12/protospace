require 'rails_helper'

describe User, type: :model do
  describe 'validation' do
    let(:name) { 'testname' }
    let(:email) { 'test@test.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { password }
    let(:avatar) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'avatar.jpg'), 'image/jpeg') }
    let(:profile) { 'テストプロフィール' }
    let(:position) { 'テスト職種' }
    let(:occupation) { 'テスト職業' }
    let(:user) { build(:user, name: name, email: email, password: password, password_confirmation: password_confirmation, avatar: avatar, profile: profile, position: position, occupation: occupation) }
    before { user.valid? }

    context 'when valid' do
      it { expect(user).to be_valid }
      context 'when avatar is nil' do
        let(:avatar) { nil }
        it { expect(user).to be_valid }
      end
      context 'when profile is nil' do
        let(:profile) { nil }
        it { expect(user).to be_valid }
      end
      context 'when position is nil' do
        let(:position) { nil }
        it { expect(user).to be_valid }
      end
      context 'when occupation is nil' do
        let(:occupation) { nil }
        it { expect(user).to be_valid }
      end
    end
    context 'with invalid' do
      context 'when name is nil' do
        let(:name) { nil }
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:name]).to include('を入力してください') }
      end
      context 'when email is nil' do
        let(:email) { nil }
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:email]).to include('を入力してください') }
      end
      context 'when password is nil' do
        let(:password) { nil }
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:password]).to include('を入力してください') }
      end
      context 'when password length is less than 6 chars' do
        let(:password) { 'a' * 5 }
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:password]).to include('は6文字以上で入力してください') }
      end
      context 'when password and password_confirmation are different' do
        let(:password_confirmation) { 'wrong_password' }
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:password_confirmation]).to include('とPasswordの入力が一致しません') }
      end
      context 'when duplicate name' do
        before do
          create(:user, name: name, email: 'other@test.com')
          user.valid?
        end
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:name]).to include('はすでに存在します') }
      end
      context 'when duplicate email' do
        before do
          create(:user, name: 'other_name', email: email)
          user.valid?
        end
        it { expect(user).not_to be_valid }
        it { expect(user.errors[:email]).to include('はすでに存在します') }
      end
    end
  end

  describe 'dependent: :destroy option' do
    let!(:user) { create(:user) }

    context 'when user deleted' do
      let!(:prototype) { create(:prototype, user: user) }
      context 'with prototype' do
        it { expect { user.destroy }.to change { Prototype.count }.by(-1) }
      end
      context 'with like' do
        let(:other_user) { create(:user, name: 'other_name', email: 'other@test.com') }
        before { create(:like, user: other_user, prototype: prototype) }
        it { expect { user.destroy }.to change { Like.count }.by(-1) }
      end
      context 'with comment' do
        before { create(:comment, user: user, prototype: prototype) }
        it { expect { user.destroy }.to change { Comment.count }.by(-1) }
      end
    end
  end
end

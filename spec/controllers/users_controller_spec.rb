require 'rails_helper'

describe UsersController, type: :controller do
  context 'when user signed in' do
    login_user
    let(:current_user) { subject.current_user }

    describe 'GET #edit' do
      before { get :edit }
      it { expect(assigns(:user)).to eq current_user }
      it { expect(response).to render_template :edit }
    end

    describe 'PATCH #update' do
      let(:new_name) { 'new_name' }
      let(:new_email) { 'new@test.com' }
      let(:new_profile) { '新しいプロフィール' }
      let(:new_position) { '新しい職種' }
      let(:new_occupation) { '新しい職業' }
      let(:params) do
        { user: { name: new_name, email: new_email, profile: new_profile, position: new_position, occupation: new_occupation } }
      end
      before { patch :update, params: params }

      context 'when valid attributes' do
        shared_examples_for 'user_successfully_updated' do
          it { expect(assigns(:user)).to eq current_user }
          it 'updates to new attributes' do
            current_user.reload
            expect(current_user.name).to eq(new_name)
            expect(current_user.email).to eq(new_email)
            expect(current_user.profile).to eq(new_profile)
            expect(current_user.position).to eq(new_position)
            expect(current_user.occupation).to eq(new_occupation)
          end
          it { expect(response).to redirect_to root_url }
          it { expect(flash[:notice]).to eq 'ユーザー情報を更新しました。' }
        end
        it_behaves_like 'user_successfully_updated'
        context 'when blank profile' do
          let(:new_profile) { '' }
          it_behaves_like 'user_successfully_updated'
        end
        context 'when blank position' do
          let(:new_position) { '' }
          it_behaves_like 'user_successfully_updated'
        end
        context 'when blank occupation' do
          let(:new_occupation) { '' }
          it_behaves_like 'user_successfully_updated'
        end
      end
      context 'when invalid attributes' do
        shared_examples_for 'user_failed_to_update' do
          it { expect(assigns(:user)).to eq current_user }
          it { expect(response).to render_template :edit }
          it { expect(flash[:warning]).to eq 'ユーザー情報の更新に失敗しました。' }
        end
        context 'when name is nil' do
          let(:new_name) { nil }
          it_behaves_like 'user_failed_to_update'
        end
        context 'when email is nil' do
          let(:new_email) { nil }
          it_behaves_like 'user_failed_to_update'
        end
      end
    end

    describe 'GET #show' do
      let!(:user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototypes) { create_list(:prototype, 2, user: user) }
      before { get :show, params: { id: user.id } }
      it { expect(assigns(:user)).to eq user }
      it { expect(assigns(:prototypes)).to eq prototypes }
      it { expect(response).to render_template :show }
    end
  end

  context 'when user is not signed in' do
    shared_examples_for 'redirect_to_login_page' do
      it { expect(response).to redirect_to new_user_session_path }
    end
    describe 'GET #edit' do
      before { get :edit }
      it_behaves_like 'redirect_to_login_page'
    end
    describe 'PATCH #update' do
      before { patch :update }
      it_behaves_like 'redirect_to_login_page'
    end
    describe 'GET #show' do
      let!(:user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototypes) { create_list(:prototype, 2, user: user) }
      before { get :show, params: { id: user.id } }
      it { expect(assigns(:user)).to eq user }
      it { expect(assigns(:prototypes)).to eq prototypes }
      it { expect(response).to render_template :show }
    end
  end
end

require 'rails_helper'

describe PrototypesController, type: :controller do
  context 'user signed in' do
    login_user
    let(:current_user) { subject.current_user }

    describe 'GET #index' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototypes) { create_list(:prototype, 2, user: other_user) }
      before { get :index }

      it { expect(assigns(:prototypes)).to eq prototypes }
      it { expect(response).to render_template :index }
    end

    describe 'GET #show' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototype) { create(:prototype, user: other_user) }
      before { get :show, params: { id: prototype.id } }

      it { expect(assigns(:prototype)).to eq prototype }
      it { expect(assigns(:user)).to eq other_user }
      it { expect(response).to render_template :show }
    end

    describe 'GET #new' do
      before { get :new }
      it { expect(assigns(:prototype)).to be_a(Prototype) }
      it { expect(response).to render_template :new }
    end

    describe 'POST #create' do
      let(:title) { 'タイトル' }
      let(:catch_copy) { '新しいキャッチコピー' }
      let(:concept) { '新しいコンセプト' }
      let(:params) do
        { prototype: { user: current_user, title: title, catch_copy: catch_copy, concept: concept } }
      end
      before { post :create, params: params }

      context 'when successfully created' do
        shared_examples_for 'successfully_created' do
          it 'creates correct attributes' do
            expect(assigns(:prototype).title).to eq title
            expect(assigns(:prototype).catch_copy).to eq catch_copy
            expect(assigns(:prototype).concept).to eq concept
          end
          it { expect(response).to redirect_to root_url }
          it { expect(flash[:notice]).to eq 'プロトタイプを投稿しました。' }
        end
        it_behaves_like 'successfully_created'
        context 'when blank catch_copy' do
          let(:catch_copy) { '' }
          it_behaves_like 'successfully_created'
        end
        context 'when blank concept' do
          let(:concept) { '' }
          it_behaves_like 'successfully_created'
        end
      end
      context 'when failed to create' do
        context 'when blank title' do
          let(:title) { '' }
          it { expect(response).to render_template :new }
          it { expect(flash[:warning]).to eq 'プロトタイプの投稿に失敗しました。' }
        end
      end
    end

    describe 'GET #edit' do
      let!(:prototype) { create(:prototype, user: current_user) }
      before { get :edit, params: { id: prototype.id } }
      it { expect(assigns(:prototype)).to eq prototype }
      it { expect(response).to render_template :edit }
    end

    describe 'PATCH #update' do
      let!(:prototype) { create(:prototype, user: current_user) }
      let(:new_title) { '新しいタイトル' }
      let(:new_catch_copy) { '新しいキャッチコピー' }
      let(:new_concept) { '新しいコンセプト' }
      let(:params) do
        { id: prototype.id, prototype: { user: current_user, title: new_title, catch_copy: new_catch_copy, concept: new_concept } }
      end
      before { patch :update, params: params }

      context 'when successfully updated' do
        shared_examples_for 'successfully_updated' do
          it 'updates to new_attributes' do
            prototype.reload
            expect(prototype.title).to eq new_title
            expect(prototype.catch_copy).to eq new_catch_copy
            expect(prototype.concept).to eq new_concept
          end
          it { expect(assigns(:prototype)).to eq prototype }
          it { expect(response).to redirect_to root_url }
          it { expect(flash[:notice]).to eq 'プロトタイプを更新しました。' }
        end
        it_behaves_like 'successfully_updated'
        context 'when blank catch_copy' do
          let(:new_catch_copy) { '' }
          it_behaves_like 'successfully_updated'
        end
        context 'when blank concept' do
          let(:new_concept) { '' }
          it_behaves_like 'successfully_updated'
        end
      end
      context 'when failed to update' do
        context 'when blank title' do
          let(:new_title) { '' }
          it { expect(response).to render_template :edit }
          it { expect(flash[:warning]).to eq 'プロトタイプの更新に失敗しました。' }
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:prototype) { create(:prototype, user: current_user) }
      before { delete :destroy, params: { id: prototype.id } }
      it { expect(assigns(:prototype)).to eq prototype }
      it { expect(response).to redirect_to root_url }
      it { expect(flash[:notice]).to eq 'プロトタイプを削除しました。' }
    end
  end

  context 'when user is not signed in' do
    describe 'GET #index' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototypes) { create_list(:prototype, 2, user: other_user) }
      before { get :index }

      it { expect(assigns(:prototypes)).to eq prototypes }
      it { expect(response).to render_template :index }
    end
    describe 'POST #create' do
      before { post :create }
      it { expect(response).to redirect_to new_user_session_path }
    end
    describe 'GET #edit' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototype) { create(:prototype, user: other_user) }
      before { get :edit, params: { id: prototype.id } }
      it { expect(response).to redirect_to new_user_session_path }
    end
    describe 'PATCH #update' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototype) { create(:prototype, user: other_user) }
      before { patch :update, params: { id: prototype.id } }
      it { expect(response).to redirect_to new_user_session_path }
    end
    describe 'DELETE #destroy' do
      let!(:other_user) { create(:user, name: 'other_user', email: 'other@test.com') }
      let!(:prototype) { create(:prototype, user: other_user) }
      before { delete :destroy, params: { id: prototype.id } }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end
end

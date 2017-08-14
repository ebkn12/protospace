require 'rails_helper'

describe UsersController do
  context 'user signed in' do
    login_user
    let(:user) { subject.current_user }

    describe 'GET #edit' do
      before do
        get :edit, id: user.id
      end

      it 'assigns current_user to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      let(:user_params) {{
        id: user.id,
        user: attributes_for(:user, name: Faker::StarWars.character)
      }}

      context 'success to update' do
        before do
          patch :update, user_params
        end

        it 'assigns current_user to @user' do
          expect(assigns(:user)).to eq user
        end

        it 'redirect_to root_url' do
          expect(response).to redirect_to root_url
        end

        it 'displays the flash message' do
          expect(flash[:notice]).to eq 'ユーザー情報を更新しました。'
        end
      end

      context 'fail to update' do
        before do
          patch :update, user_params.merge!(user: { name: nil })
        end

        it 'assigns current_user to @user' do
          expect(assigns(:user)).to eq user
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end

        it 'displays the flash message' do
          expect(flash[:warning]).to eq 'ユーザー情報の更新に失敗しました。'
        end
      end
    end

    describe 'GET #show' do
      before do
        get :show, id: user.id
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'assigns prototypes related @user to @prototypes' do

      end

      it 'renders the :edit template' do
        expect(response).to render_template :show
      end
    end
  end

  context "user didn't signed in" do
    let(:user) { create(:user) }

    describe 'GET #edit' do
      it 'redirects sign_in page' do
        get :edit, id: user.id
        expect(response).to redirect_to new_user_session_path
      end

      it 'displays the flash message' do
        expect(flash[:alert]).to eq 'ログインまたは登録が必要です'
      end
    end

    describe 'PATCH #update' do
      it 'redirects sign_in page' do
        patch :update, {
          id: user.id,
          user: attributes_for(:user, name: Faker::StarWars.character)
        }
        expect(response).to redirect_to new_user_session_path
      end

      it 'displays the flash message' do
        expect(flash[:alert]).to eq 'ログインまたは登録が必要です。'
      end
    end
  end
end

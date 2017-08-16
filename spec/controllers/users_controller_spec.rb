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
      let(:sample_name) { Faker::StarWars.character }
      let(:user_params) {{
        id: user.id,
        user: attributes_for(:user, name: sample_name)
      }}

      context 'success to update' do
        before do
          patch :update, user_params
        end

        it 'assigns current_user to @user' do
          expect(assigns(:user)).to eq user
        end

        it "changes @user's name" do
          expect(user.name).to eq sample_name
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
      let(:test_user) {
        create(
          :user,
          name: Faker::StarWars.character,
          email: Faker::Internet.email
        )
      }
      before do
        get :show, id: test_user.id
      end

      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq test_user
      end

      it 'assigns prototypes related @user to @prototypes' do
        prototype = create(:prototype, user_id: test_user.id)
        expect(test_user.related_prototypes(1).first).to eq prototype
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
    end

    describe 'PATCH #update' do
      it 'redirects sign_in page' do
        patch :update, {
          id: user.id,
          user: attributes_for(:user, name: Faker::StarWars.character)
        }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

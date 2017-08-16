require 'rails_helper'

describe PrototypesController do
  let(:user) { subject.current_user }
  let(:test_user) {
    create(
      :user,
      name: Faker::StarWars.character,
      email: Faker::Internet.email
    )
  }
  let(:prototype) { create(:prototype, user_id: test_user.id) }
  let(:sample_title) { Faker::StarWars.character }
  let(:prototype_params) {{
    id: prototype.id,
    prototype: attributes_for(:prototype, title: sample_title)
  }}
  let(:invalid_prototype_params) {{
    id: prototype.id,
    prototype: attributes_for(:prototype, title: nil)
  }}

  context 'user signed in' do
    login_user

    describe 'GET #index' do
      before { get :index }

      it 'assigns the requested prototypes order by newest' do
        proto1 = create(:prototype, user_id: user.id, created_at: Date.today)
        proto2 = create(:prototype, user_id: test_user.id, created_at: Date.tomorrow)
        expect(assigns(:prototypes)).to eq [proto2, proto1]
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      before { get :show, id: prototype.id }

      it 'assigns the requested prototype' do
        expect(assigns(:prototype)).to eq prototype
      end

      it 'assigns the user related prototype' do
        expect(assigns(:user)).to eq test_user
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'success to create prototype' do
        before do
          post :create, prototype_params
        end

        it 'redirects to root_url' do
          expect(response).to redirect_to root_url
        end

        it 'displays the flash message' do
          expect(flash[:notice]).to eq 'プロトタイプを投稿しました。'
        end
      end

      context 'fail to create prototype' do
        before do
          post :create, invalid_prototype_params
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end

        it 'displays the flash message' do
          expect(flash[:warning]).to eq 'プロトタイプの投稿に失敗しました。'
        end
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: prototype.id }

      it 'assigns the requested prototype' do
        expect(assigns(:prototype)).to eq prototype
      end
    end

    describe 'PATCH #update' do
      context 'success to update prototype' do
        before do
          patch :update, prototype_params
        end

        it 'assigns the requested prototype' do
          expect(assigns(:prototype)).to eq prototype
        end

        it 'redirects to root_url' do
          expect(response).to redirect_to root_url
        end

        it 'displays the flash message' do
          expect(flash[:notice]).to eq 'プロトタイプを更新しました。'
        end
      end

      context 'fail to update prototype' do
        before do
          patch :update, invalid_prototype_params
        end

        it 'assigns the requested prototype' do
          expect(assigns(:prototype)).to eq prototype
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end

        it 'displays the flash message' do
          expect(flash[:warning]).to eq 'プロトタイプの更新に失敗しました。'
        end
      end
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, id: prototype.id }

      it 'redirects to root_url' do
        expect(response).to redirect_to root_url
      end

      it 'displays the flash message' do
        expect(flash[:notice]).to eq 'プロトタイプを削除しました。'
      end
    end
  end

  context "user didn't signed in" do
    describe 'POST #create' do
      it 'redirects to sign_in page' do
        post :create, prototype_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #edit' do
      it 'redirects to sign_in page' do
        get :edit, id: prototype.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PATCH #update' do
      it 'redirects to sign_in page' do
        patch :update, prototype_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to sign_in page' do
        delete :destroy, id: prototype.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

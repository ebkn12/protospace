require 'rails_helper'

describe UsersController do
  describe 'GET #edit' do
    before do
      get :edit
    end

    it 'assigns current_user to @user' do
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'success to update' do
      it 'assigns current_user to @user' do
      end

      it 'redirect_to root_url' do
        expect(response).to redirect_to root_url
      end

      it 'displays the flash message' do
      end
    end

    context 'fail to update' do
      it 'assigns current_user to @user' do
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
    end

    it 'assigns prototypes related @user to @prototypes' do
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end
end

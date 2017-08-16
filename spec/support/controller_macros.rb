module ControllerMacros
  def login_user
    before do
      allow(controller).to receive(:authenticate_user!).and_return true
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in create(:user)
    end
  end
end

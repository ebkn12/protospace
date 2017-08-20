require 'rails_helper'

feature 'User', js: true do
  let(:user) { build(:user) }

  def sign_up(user)
    fill_in 'user_name',                  with: user.name
    fill_in 'user_email',                 with: user.email
    fill_in 'user_password',              with: user.password
    fill_in 'user_password_confirmation', with: user.password
    fill_in 'user_position',              with: user.position
    fill_in 'user_profile',               with: user.profile
    fill_in 'user_occupation',            with: user.occupation
    click_button 'Sign up'
  end

  scenario 'Create new user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'
  end
end

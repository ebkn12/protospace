require 'rails_helper'

feature 'User', js: true do
  let(:user) { build(:user) }

  def sign_up(user)
    fill_in 'user_name',                  with: user.name
    fill_in 'user_email',                 with: user.email
    fill_in 'user_password',              with: user.password
    fill_in 'user_password_confirmation', with: user.password
    attach_file(
      'user[avatar]',
      File.join(Rails.root, '/spec/fixtures/images/avatar.jpg'),
      visible: false
    )
    fill_in 'user_position',              with: user.position
    fill_in 'user_profile',               with: user.profile
    fill_in 'user_occupation',            with: user.occupation
    click_button 'Sign up'
  end

  def sign_in(user)
    fill_in 'user[email]',    with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Sign in'
  end

  scenario 'Create new user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'
  end

  scenario 'Log in user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'

    click_on user.name
    click_on 'Logout'
    click_on 'Get Started'
    sign_in(user)
    expect(page).to have_selector '.alert-notice', text: 'ログインしました。'
  end

  scenario 'Edit user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'

    click_on user.name
    click_on 'Edit profile'
    fill_in 'user[name]',     with: Faker::StarWars.character
    fill_in 'user[password]', with: user.password
    click_on 'Save'
    expect(page).to have_selector '.alert-notice', text: 'ユーザー情報を更新しました。'
  end

  scenario 'Log out user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'

    click_on user.name
    click_on 'Logout'
    expect(page).to have_selector '.alert-notice', text: 'ログアウトしました。'
  end
end

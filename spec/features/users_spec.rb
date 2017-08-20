require 'rails_helper'

feature 'User', js: true do
  let(:user) { build(:user) }

  before do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'
  end

  scenario 'Create new user', js: true do
  end

  scenario 'Log in user', js: true do
    click_on user.name
    click_on 'Logout'
    click_on 'Get Started'
    sign_in(user)
    expect(page).to have_selector '.alert-notice', text: 'ログインしました。'
  end

  scenario 'Edit user', js: true do
    click_on user.name
    click_on 'Edit profile'
    fill_in 'user[name]',     with: Faker::StarWars.character
    fill_in 'user[password]', with: user.password
    click_on 'Save'
    expect(page).to have_selector '.alert-notice', text: 'ユーザー情報を更新しました。'
  end

  scenario 'Log out user', js: true do
    click_on user.name
    click_on 'Logout'
    expect(page).to have_selector '.alert-notice', text: 'ログアウトしました。'
  end
end

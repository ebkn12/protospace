require 'rails_helper'

describe 'users', type: :system do
  let!(:user) { create(:user) }
  let(:new_user) { build(:user) }
  let(:new_name) { 'new_name' }
  let(:new_email) { 'new@test.com' }
  let(:new_password) { 'new_pass' }
  let(:new_position) { 'new_position' }
  let(:new_profile) { 'new_profile' }
  let(:new_occupation) { 'new_occupation' }

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Sign in'
  end

  it 'completes to log in' do
    login
    expect(page).to have_content(user.name)
    expect(page).to have_selector('.alert-notice', text: 'ログインしました')
  end
  it 'completes to sign up' do
    visit new_user_registration_path
    fill_in 'user_name', with: new_user.name
    fill_in 'user_email', with: new_user.email
    fill_in 'user_password', with: new_user.password
    fill_in 'user_password_confirmation', with: new_user.password
    attach_file('user[avatar]', Rails.root.join('spec', 'fixtures', 'images', 'avatar.jpg'), visible: false)
    fill_in 'user_position', with: new_user.position
    fill_in 'user_profile', with: new_user.profile
    fill_in 'user_occupation', with: new_user.occupation
    click_on 'Sign up'

    expect(page).to have_content(new_user.name)
    expect(page).to have_selector('.alert-notice', text: 'アカウント登録を受け付けました。')
  end
  it 'completes to edit user', js: true do
    login
    click_on user.name
    click_on 'Edit profile'

    fill_in 'user[name]', with: new_name
    fill_in 'user[email]', with: new_email
    fill_in 'user[password]', with: new_password
    fill_in 'user[password_confirmation]', with: new_password
    fill_in 'user[position]', with: new_position
    fill_in 'user[profile]', with: new_profile
    fill_in 'user[occupation]', with: new_occupation
    click_on 'Save'

    expect(page).to have_selector('.alert-notice', text: 'ユーザー情報を更新しました。')
  end
  it 'completes to log out', js: true do
    login
    click_on user.name
    click_on 'Logout'

    expect(page).not_to have_content user.name
    expect(page).to have_content('GET STARTED')
    expect(page).to have_selector('.alert-notice', text: 'ログアウトしました。')
  end
end

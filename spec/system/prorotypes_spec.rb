require 'rails_helper'

describe 'prototypes', type: :system do
  let!(:user) { create(:user) }
  let!(:prototypes) { create_list(:prototype, 2) }
  let!(:prototype) { create(:prototype, user: user) }
  let(:new_title) { 'new_title' }
  let(:new_catch_copy) { 'new_catch_copy' }
  let(:new_concept) { 'new_concept' }

  def login
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Sign in'
  end

  it 'completes to create prototype' do
    login
    visit new_prototype_path
    fill_in 'prototype_title', with: new_title
    fill_in 'prototype_catch_copy', with: new_catch_copy
    fill_in 'prototype_concept', with: new_concept
    attach_file('prototype[captured_images_attributes][0][content]', Rails.root.join('spec', 'fixtures', 'images', 'prototype.jpg'), visible: false)
    3.times { |i| attach_file("prototype[captured_images_attributes][#{i + 1}][content]", Rails.root.join('spec', 'fixtures', 'images', 'prototype.jpg'), visible: false) }
    click_on 'Publish'

    expect(page).to have_selector('.alert-notice', text: 'プロトタイプを投稿しました。')
  end
  it 'completes to edit prototype', js: true do
    login
    visit mypage_users_path
    click_on 'Action'
    click_on 'Edit'
    fill_in 'prototype_title', with: new_title
    fill_in 'prototype_catch_copy', with: new_catch_copy
    fill_in 'prototype_concept', with: new_concept
    click_on 'Update'

    expect(page).to have_selector('.alert-notice', text: 'プロトタイプを更新しました。')
  end
  it 'completes to destroy prototypes', js: true do
    login
    visit mypage_users_path
    click_on 'Action'
    click_on 'Delete'

    expect(page).to have_selector('.alert-notice', text: 'プロトタイプを削除しました。')
  end
  it 'completes to show prototypes index' do
    visit root_path
    expect(page).to have_selector('.proto-content')
  end
  it 'completes to show prototype detail' do
    visit prototype_path(prototype)
    expect(page).to have_selector('.proto-page')
  end
end

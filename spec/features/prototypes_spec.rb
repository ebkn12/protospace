require 'rails_helper'

feature 'Prototype', js: true do
  let(:user) { build(:user) }

  before do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'

    click_on 'New Proto'
    prototype = build(:prototype, user_id: user.id)
    post_prototype(prototype)
    expect(page).to have_selector '.alert-notice', text: 'プロトタイプを投稿しました。'
  end

  scenario 'Post prototype', js: true do
  end

  scenario 'Edit prototype', js: true do
    click_on 'Action'
    click_on 'Edit'
    fill_in 'prototype_title', with: Faker::StarWars.quote
    click_on 'Update'
    expect(page).to have_selector '.alert-notice', text: 'プロトタイプを更新しました。'
  end

  scenario 'Delete prototype', js: true do
    click_on 'Action'
    click_on 'Delete'
    expect(page).to have_selector '.alert-notice', text: 'プロトタイプを削除しました。'
  end
end

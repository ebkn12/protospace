require 'rails_helper'

feature 'Prototype', js: true do
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

  def sign_in(user)
    fill_in 'user[email]',    with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Sign in'
  end

  scenario 'post prototype', js: true do
    def post_prototype(prototype)
      fill_in 'prototype_title',      with: prototype.title
      fill_in 'prototype_catch_copy', with: prototype.catch_copy
      fill_in 'prototype_concept',    with: prototype.concept
      attach_file(
        'prototype[captured_images_attributes][0][content]',
        File.join(Rails.root, '/spec/fixtures/images/prototype.jpg'),
        visible: false
      )
      3.times do |i|
        attach_file(
          "prototype[captured_images_attributes][#{i + 1}][content]",
          File.join(Rails.root, '/spec/fixtures/images/prototype.jpg'),
          visible: false
        )
      end
      click_on 'Publish'
    end

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

    click_on 'New Proto'
    prototype = build(:prototype, user_id: user.id)
    post_prototype(prototype)
    expect(page).to have_selector '.alert-notice', text: 'プロトタイプを投稿しました。'
  end
end

require 'rails_helper'

feature 'Like', js: true do
  let(:user) { build(:user) }
  let(:prototype) { build(:prototype, user_id: user.id) }

  before do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    sign_up(user)
    expect(page).to have_selector '.alert-notice', text: 'アカウント登録を受け付けました。'

    click_on 'New Proto'
    post_prototype(prototype)
    expect(page).to have_selector '.alert-notice', text: 'プロトタイプを投稿しました。'
  end

  scenario 'Like prototype', js: true do
    page.first('.proto-content .thumbnail a').click
    click_on 'Like'
    sleep 2
    expect(find('#like_button form button img')[:src]).to include '/assets/icon_heart_red-be83584b12c256fdf58ef2201b5e227e26649b01f561f70335d78de5e108fa20.svg'
  end

  scenario 'Unlike prototype', js: true do
    page.first('.proto-content .thumbnail a').click
    click_on 'Like'
    sleep 2
    click_on 'Like'
    sleep 2
    expect(find('#like_button form button img')[:src]).to include '/assets/icon_heart-20100b1c862f59bb23666746a16cdbd86d418436888ef57ed262f5baa649a69c.svg'
  end
end

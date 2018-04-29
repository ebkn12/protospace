require 'rails_helper'

describe 'likes', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:prototype) { create(:prototype, user: other_user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Sign in'
  end

  it 'completes to create like', js: true do
    visit prototype_path(prototype)
    click_on 'Like'
    sleep 1

    # TODO
    # expect(page.find('#like_button form button img')[:src].include?('icon_heart_red')).to be_truthy
  end

  it 'completes to destroy like', js: true do
    create(:like, prototype: prototype, user: user)
    visit prototype_path(prototype)
    click_on 'Like'
    sleep 1

    icon_source = page.find('#like_button form button img')[:src]
    # TODO
    # expect(icon_source.include?('icon_heart')).to be_truthy
    # expect(icon_source.include?('icon_heart_red')).to be_falsey
  end
end

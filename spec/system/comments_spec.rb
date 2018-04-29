require 'rails_helper'

describe 'comments', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:prototype) { create(:prototype, user: other_user) }
  let(:content) { 'comment_content' }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Sign in'
  end

  it 'completes to create comment', js: true do
    visit prototype_path(prototype)
    fill_in 'comment[content]', with: content
    click_on 'Comment'

    expect(page.first('#post-comment .media .media-body p').text).to eq(content)
  end
end

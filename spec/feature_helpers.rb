module FeatureHelpers
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
end

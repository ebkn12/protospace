ApplicationRecord.transaction do
  puts 'Creating ebkn12...'
  User.create(
    name: 'ebkn12',
    email: 'test@test.com',
    password: 'password',
    avatar: nil,
    profile: 'エンジニア見習いです',
    occupation: '学生',
    position: 'B3'
  )

  puts 'Creating users...'
  1.upto(10) do |n|
    User.create(
      name: "testuser_#{n}",
      email: "test_#{n}@test.com",
      password: 'password',
      avatar: nil,
      profile: 'プロフィール',
      occupation: '学生',
      position: 'B3'
    )
  end

  puts 'Creating prototypes...'
  users = User.all
  users.each do |user|
    other_users = users.where.not(id: user.id)
    1.upto(10) do |n|
      p = Prototype.create(
        title: "プロトタイプサンプル No.#{n}",
        catch_copy: "キャッチコピー_#{n}",
        concept: "コンセプト_#{n}",
        user: user
      )
      rand(15).times do
        Comment.create(
          content: 'コメント',
          user: other_users.sample,
          prototype: p
        )
      end
      other_users.sample(rand(other_users.size)).each do |likable_user|
        Like.create(
          user: likable_user,
          prototype: p
        )
      end
    end
  end
end

class CreatePrototypes < ActiveRecord::Migration[5.1]
  def change
    create_table :prototypes do |t|
      t.text :title, null: false
      t.text :catch_copy
      t.text :concept
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

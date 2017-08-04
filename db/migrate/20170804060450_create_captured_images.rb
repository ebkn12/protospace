class CreateCapturedImages < ActiveRecord::Migration[5.0]
  def change
    create_table :captured_images do |t|
      t.text :content, null: false
      t.integer :status, null: false, default: 0, limit: 1
      t.references :prototype, null: false, foreign_key: true

      t.timestamps
    end
  end
end

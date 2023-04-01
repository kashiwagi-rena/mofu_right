class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.string :body, null: false
      #t.binary :photo, null: false
      #t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

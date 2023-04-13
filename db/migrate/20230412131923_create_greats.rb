class CreateGreats < ActiveRecord::Migration[7.0]
  def change
    create_table :greats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
      #同じユーザーが、同じ掲示板に複数回「お気に入り」をすることを防ぐ
      t.index [:user_id, :post_id], unique: true
    end
  end
end

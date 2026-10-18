class CreateBulletins < ActiveRecord::Migration[8.1]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :state, null: false, default: "draft"
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bulletins, :state
  end
end

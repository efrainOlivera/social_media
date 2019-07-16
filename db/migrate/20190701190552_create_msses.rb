class CreateMsses < ActiveRecord::Migration[5.0]
  def change
    create_table :msses do |t|
      t.string :messages
      t.integer :likes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

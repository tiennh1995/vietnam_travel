class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.integer :sex, default: 0
      t.string :avatar
      t.string :cover
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end

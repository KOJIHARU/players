class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :players_name
      t.string :country
      t.integer :status
      t.string :type

      t.timestamps null: false
    end
  end
end

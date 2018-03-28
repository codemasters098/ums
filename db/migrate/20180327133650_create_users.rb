class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :admin
      t.string :password
      t.boolean :activated

      t.timestamps
    end
  end
end

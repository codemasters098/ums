class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :admin
      t.string :password

      t.timestamps
    end
  end
end



#User.create!(:first_name=>'Louise', :last_name=> 'Heneghan', :username=>'louiseheneghan', :admin=>true, :activated=>true, :email => 'louheneghan@gmail.com', :password => 'Griffith123.', :password_confirmation => 'Griffith123.')

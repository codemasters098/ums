class User < ApplicationRecord
	
	has_secure_password

	validates_length_of :first_name, :maximum => 20
	validates_length_of :last_name, :maximum => 20

	validates_length_of :username, :maximum => 30
	validates :username, :presence => true

	validates :email, :presence => true
	validates :password, confirmation: true
	validates :password_confirmation, :presence => true

	validates :username, format: { without: /\s/ }
	validates_format_of :email, :with => /\A\S+@.+\.\S+\z/

end

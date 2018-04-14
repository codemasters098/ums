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

	attr_accessor :remember_token, :activation_token, :reset_token

  	before_save   :downcase_email
  	before_create :create_activation_digest


  	def authenticated?(attribute, token)
	    digest = send("#{attribute}_digest")
	    return false if digest.nil?
	    BCrypt::Password.new(digest).is_password?(token)
	end

	def activate
    	update_attribute(:activated,    true)
    	update_attribute(:activated_at, Time.zone.now)
	end

	# Sets the password reset attributes.
    def create_reset_digest
	    self.reset_token = User.new_token
	    update_attribute(:reset_digest,  User.digest(reset_token))
	    update_attribute(:reset_sent_at, Time.zone.now)
    end

  # Sends password reset email.
    def send_password_reset_email
    	UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
    	reset_sent_at < 2.hours.ago
 	end

  	private

  	def User.new_token
    	SecureRandom.urlsafe_base64
	end

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
 	end

 	

	

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end

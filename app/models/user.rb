class User < ApplicationRecord
  has_many :organisations, dependent: :destroy
	attr_accessor :remember_token, :reset_token
  # ensures that duplicate emails with different cases can't be used
	before_save { self.email = email.downcase }
  # validates that a name exists and is no more than 50 characters
	validates :name, presence: true, length: { maximum: 50 }

	# regular expressions used to validate an e-mail address
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validates that the e-mail exists, is the correct format and is shorter than 255 characters
	validates :email, presence: true, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }

  #used to ensure that the password is encrypted and secure          
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # checks if the user is authenticated
	def authenticated?(remember_token)
	  return false if remember_digest.nil?
	  BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
	  update_attribute(:remember_digest, nil)
	end


  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

    # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # checks if the password reset is expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end

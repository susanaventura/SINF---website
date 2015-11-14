class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  attr_accessor :name, :taxpayer_num, :address, :local, :postal_address
  before_save :downcase_email, :upcase_username

  validates :name, presence: true, length: {maximum: 50}
  VALID_TAXPAYER_NUM_REGEX = /\A[0-9]{9}\z/i
  validates :taxpayer_num, format: {with: VALID_TAXPAYER_NUM_REGEX, message: 'is a 9 digit number.'}
  validates :address, presence: true
  validates :local, presence: true

  validates :username, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, {length: {maximum: 255},
                     format: {with: VALID_EMAIL_REGEX},
                     uniqueness: {case_sensitive: false}
  })

  VALID_POSTAL_CODE_REGEX = /\A[0-9]{4}-[0-9]{3}\z/i
  validates(:postal_address, {format: {with: VALID_POSTAL_CODE_REGEX,  message: 'is not valid. Format: XXXX-XXX'}})

  has_secure_password
  validates(:password, presence: true, length: {minimum: 6}, allow_nil: true)

  def User.attributes
    [:username, :email, :password, :password_confirmation] + [:name, :taxpayer_num, :address, :local, :postal_address]
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end




  private

  def downcase_email
    self.email = email.downcase
  end

  def upcase_username
    self.username = username.upcase
  end

end

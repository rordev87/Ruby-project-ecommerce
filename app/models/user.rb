class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  require 'date'
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :suggestions, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user_name, presence: true, uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/
  has_secure_password
  validates :password, presence: true,
    format: {with: VALID_PASSWORD_REGEX}
  validates :avatar, presence: true
  validates :is_admin, inclusion: {in: [true, false]}
  validates :activated, inclusion: {in: [true, false]}
   scope :list_users_desc, -> {order(created_at: :desc)}
  # Create digest token use BCrypt
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Create new token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forget User
  def forget
    update_attribute(:remember_digest, nil)
  end

   # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at,DateTime.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Create activation digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end

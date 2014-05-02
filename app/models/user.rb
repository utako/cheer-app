class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, :session_token, null: false
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  def self.find_by_credentials(creds)
    user = User.find_by_username(creds[:username])
    return user if user.is_password?(creds[:password])
    nil
  end

  def password=(password)
    @password = password
    password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.hex
  end

end

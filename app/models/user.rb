# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  include Commentable

  validates :username, presence: true
  validates :password, presence: true

  has_many :goals

  def to_s
    self.username
  end


  def password
    self.password_digest
  end

  def password=(plain_text)
    if plain_text.empty?
      errors.add(:password, "can't be blank")
    elsif plain_text.length < 6
      errors.add(:password, "is too short")
    else
      self.password_digest = BCrypt::Password.create(plain_text)
    end
  end

  def is_password?(plain_text)
    BCrypt::Password.new(self.password_digest).is_password?(plain_text)
  end

  def reset_session_token
    self.update(session_token: SecureRandom::urlsafe_base64(16))
    self.session_token
  end

  def self.find_by_credentials(user_params)
    user = self.find_by(username: user_params[:username])
    return user if user && user.is_password?(user_params[:password])
  end

end

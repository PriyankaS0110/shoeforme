class User < ApplicationRecord
  has_one_attached :avatar
  has_secure_password 
  has_secure_password :recovery_password, validations: false
  validates :email, uniqueness: {message: ' %{value} already exists, try logging in!!'} , presence: true
  validates :phone_number, length: { minimum: 10 }, uniqueness: {message: ' %{value} already exists, try logging in!!'}, presence: true
  validates :name, length: { minimum: 5 }, presence: true
  validates :password_digest, length: { minimum: 5 } , presence: true
 
  validate :avatar_format

private

  def avatar_format
    return unless avatar.attached?
    return if avatar.blob.content_type.start_with? 'image/'
    avatar.purge_later
    errors.add(:avatar, 'needs to be an image')
  end
end

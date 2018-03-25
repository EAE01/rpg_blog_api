class User < ApplicationRecord
  has_secure_password

  has_many :posts

  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true

  validates_length_of :password, minimum: 6

  def as_json(options={})
    options[:except] ||= []
    options[:except].push :password_digest

    super options
  end
end

class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :username, presence: true,
                     format: /\A[A-Z0-9]+\z/i,
                     uniqueness: { case_sensitive: false }
   has_many :reviews, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :favorite_movies, through: :favorites, source: :movie

  def gravatar_id
  	Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end
end

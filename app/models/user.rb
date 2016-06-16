class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates_confirmation_of :password
  validates_presence_of :password_confirmation, on: :create

  def self.search(search)
    if search
      where('LOWER(email) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end
end

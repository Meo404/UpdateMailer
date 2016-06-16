class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # After save actions
  after_save :create_email

  validates_confirmation_of :password
  validates_presence_of :password_confirmation, on: :create

  # Search function for the User model.
  # if search param is provided it retrieves all users where the email matches the search term
  # else it returns all email templates
  # @param  search  search term to find
  # @return search results
  def self.search(search)
    if search
      where('LOWER(email) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  private

  # Method will also add the users email to the Email collection
  # Unless email already exists
  def create_email
    Email.create(address: email) unless Email.exists?(address: email)
  end
end

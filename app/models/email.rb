class Email < ActiveRecord::Base
  has_and_belongs_to_many :distribution_lists

  # Validation RegEx
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Before Save actions
  before_save { address.downcase! }

  # Validation
  validates :address,
            presence: true,
            length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
end

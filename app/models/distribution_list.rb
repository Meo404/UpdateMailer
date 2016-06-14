class DistributionList < ActiveRecord::Base
  has_and_belongs_to_many :emails

  # Validation
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :emails, presence: true
end

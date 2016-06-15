class UpdateMail < ActiveRecord::Base
  has_and_belongs_to_many :distribution_lists

  # Before save actions
  before save :sanitize_body, :add_permalink

  # Validation
  validates :title,
      presence: true,
      length: { maximum: 255, minimum: 3 },
      uniqueness: { case_sensitive: false }
  validates :body, presence: true
end

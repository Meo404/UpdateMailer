class EmailTemplate < ActiveRecord::Base
  # Validation
  validates :name,
            presence: true,
            length: { maximum: 100, minimum: 3 },
            uniqueness: { case_sensitive: false }
  validates :template, presence: true
  validates :preview_img, presence: true
end

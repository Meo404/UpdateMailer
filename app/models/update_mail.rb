class UpdateMail < ActiveRecord::Base
  has_and_belongs_to_many :distribution_lists
  has_many :update_mail_views
  belongs_to :user

  # Before save actions
  before_save :sanitize_body

  # Before delete actions
  # Cleans relation to update mail views on deletion
  before_destroy { self.update_mail_views.clear }

  # Validation
  validates :title, presence: true, length: { maximum: 255, minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :body, presence: true
  validates :distribution_lists, presence: true

  private

  def sanitize_body
    @sanitization_service = SanitizationService.new(body)
    @sanitization_service.sanitize
  end
end

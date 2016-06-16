class EmailTemplate < ActiveRecord::Base
  # Before Save actions
  before_save :sanitize_template

  # Image Attachment
  attachment :preview_image, type: :image

  # Validation
  validates :name,
            presence: true,
            length: { maximum: 100, minimum: 3 },
            uniqueness: { case_sensitive: false }
  validates :template, presence: true
  validates :preview_image, presence: true

  # Search function for the EmailTemplate model.
  # if search param is provided it retrieves all email templates where the name matches the search term
  # else it returns all email templates
  # @param  search  search term to find
  # @return search results
  def self.search(search)
    if search
      where('LOWER(name) LIKE ?', "%#{search.downcase}%")
    else
      where(nil)
    end
  end

  private

  def sanitize_template
    @sanitization_service = SanitizationService.new(template)
    @sanitization_service.sanitize
  end
end

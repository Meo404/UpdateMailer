class UpdateMail < ActiveRecord::Base
  has_and_belongs_to_many :distribution_lists
  has_many :update_mail_views

  # Before save actions
  before_save :sanitize_body

  # Validation
  validates :title, presence: true, length: { maximum: 255, minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :body, presence: true
  validates :distribution_lists, presence: true

  # Search function for the UpdateMail model.
  # if search param is provided it retrieves all update mails where the title or any assigned distribution lists name
  # matches the search term
  # else it returns all update mails
  # @param  search  search term to find
  # @return search results
  def self.search(search)
    if search
      includes(:distribution_lists)
        .where('LOWER(distribution_lists.name) LIKE ? OR LOWER(title) LIKE ?',
               "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
    else
      where(nil)
    end
  end

  private

  def sanitize_body
    @sanitization_service = SanitizationService.new(body)
    @sanitization_service.sanitize
  end
end

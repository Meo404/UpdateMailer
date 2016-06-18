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

  # Search function for the UpdateMail model.
  # if search param is provided and the user is an admin then all records matching the search term will be returned
  # if search param is provided and the user is not an admin then all public records as well as all records of the
  # user will be returned
  # if no search param is provided and the user is an admin then all records will be returned
  # else it returns all record that are public or belong to the user
  # @param  search  search term to find
  # @param  user    current user executing the search
  # @return search results
  def self.search(search, user)
    if search && user.admin?
      admin_search(search)
    elsif search
      user_search(search, user.id)
    elsif user.admin?
      where(nil)
    else
      where('public = true OR user_id = ?', user.id)
    end
  end

  def self.admin_search(search)
    includes(:distribution_lists)
      .where('LOWER(distribution_lists.name) LIKE ? OR LOWER(title) LIKE ?',
             "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
  end

  def self.user_search(search, user_id)
    records = includes(:distribution_lists)
              .where('LOWER(distribution_lists.name) LIKE ? OR LOWER(title) LIKE ?',
                     "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
    records.where('public = true OR user_id = ?', user_id)
  end

  private

  def sanitize_body
    @sanitization_service = SanitizationService.new(body)
    @sanitization_service.sanitize
  end
end

class DistributionList < ActiveRecord::Base
  has_and_belongs_to_many :emails
  has_and_belongs_to_many :update_mails

  # Validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :emails, presence: true

  # Search function for the DistributionList model.
  # if search param is provided it retrieves all distribution lists where the name or any assigned email address
  # matches the search term
  # else it returns all distribution lists
  # @param  search  search term to find
  # @return search results
  def self.search(search)
    if search
      includes(:emails).where('LOWER(emails.address) LIKE ? OR LOWER(name) LIKE ?',
                              "%#{search.downcase}%", "%#{search.downcase}%").references(:emails)
    else
      where(nil)
    end
  end
end

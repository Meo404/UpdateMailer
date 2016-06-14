class DistributionList < ActiveRecord::Base
  has_and_belongs_to_many :emails

  # Validation
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :emails, presence: true

  def self.search(search)
    if search
      includes(:emails).where('LOWER(emails.address) LIKE ? OR LOWER(name) LIKE ?', "%#{search.downcase}%",
                              "%#{search.downcase}%").references(:emails)
    else
      where(nil)
    end
  end
end



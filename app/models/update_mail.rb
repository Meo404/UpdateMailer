class UpdateMail < ActiveRecord::Base
  has_and_belongs_to_many :distribution_lists

  # Before save actions
  # before_save :sanitize_body, :add_permalink

  # Validation
  validates :title, presence: true, length: { maximum: 255, minimum: 3 }, uniqueness: { case_sensitive: false }
  validates :body, presence: true

  def self.search(search)
    if search
      includes(:distribution_lists)
        .where('LOWER(distribution_list.name) LIKE ? OR LOWER(title) LIKE ?',
               "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
    else
      where(nil)
    end
  end
end

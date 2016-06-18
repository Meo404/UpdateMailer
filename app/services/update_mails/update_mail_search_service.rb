# Service Class to search UpdateMail records
class UpdateMailSearchService
  # Search function for the UpdateMail model.
  # if search param is provided and the user is an admin then all records matching the search term will be returned
  # if search param is provided and the user is not an admin then all public records as well as all records of the
  # user will be returned
  # if no search param is provided and the user is an admin then all records will be returned
  # else it returns all record that are public or belong to the user
  # @param  search    search term to find
  # @param  user      current user executing the search
  # @param  only_own  boolean to set if only the user onwed record shall be searched. defaults to false
  # @return search results
  def search(search, user, only_own = false)
    if only_own
      UpdateMail.where('user_id = ?', user.id)
    elsif search && user.admin?
      admin_search(search)
    elsif search
      regular_search(search, user.id)
    elsif user.admin?
      UpdateMail.where(nil)
    else
      UpdateMail.where('public = true OR user_id = ?', user.id)
    end
  end

  private

  def admin_search(search)
    UpdateMail.includes(:distribution_lists)
              .where('LOWER(distribution_lists.name) LIKE ? OR LOWER(title) LIKE ?',
                     "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
  end

  def regular_search(search, user_id)
    records = UpdateMail.includes(:distribution_lists)
                        .where('LOWER(distribution_lists.name) LIKE ? OR LOWER(title) LIKE ?',
                               "%#{search.downcase}%", "%#{search.downcase}%").references(:distribution_lists)
    records.where('public = true OR user_id = ?', user_id)
  end
end

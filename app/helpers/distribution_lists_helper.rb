module DistributionListsHelper
  # Function to replace all invalid email_ids within the params of the create/update actions.
  # if email_id is not an integer or blank the function will try to create a new Email Object for it and replace
  # it's value with the id of the newly created Email Object. (It is expected that only integer, blanks or valid email
  # addresses will be in there).
  #
  # @param  params  params hash from create/update actions
  # @return         the params hash with replaced email_ids
  def create_extra_emails(params)
    params[:distribution_list][:email_ids].map! {
        |email_id| email_id.is_i? || email_id.blank? ?  email_id : Email.create(address: email_id).id}
    return params
  end
end

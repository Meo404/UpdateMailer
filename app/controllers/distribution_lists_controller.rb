class DistributionListsController < ApplicationController
  include DistributionListsHelper
  before_filter :modify_email_ids_param, :only => [:create, :update]

  def index
    @distribution_lists = DistributionList.all
  end

  def new
    @distribution_list = DistributionList.new
  end

  def create
    @distribution_list = DistributionList.new(distribution_list_params)
    if @distribution_list.save
      # TODO - Add Flash message
      redirect_to distribution_lists_path
    else
      # TODO - Add Flash message
      render('new')
    end
  end

  def edit
    @distribution_list = DistributionList.find(params[:id])
  end

  def update
    @distribution_list = DistributionList.new(distribution_list_params)
    if @distribution_list.save
      # TODO - Add Flash message
      redirect_to distribution_lists_path
    else
      # TODO - Add Flash message
      render('new')
    end
  end

  def destroy
    if DistributionList.find(params[:id]).destroy
      # TODO - Add flash message
      redirect_to distribution_lists_path
    else
      # TODO - Add flash message
    end
  end

  private

  # Method to modify the params hash on create and update actions. See create_extra_mails comment
  # @return   modified params hash
  def modify_email_ids_param
    create_extra_emails(params)
  end

  def distribution_list_params
    params.require(:distribution_list).permit(:name, :email_ids => []) # TODO - Add additional emails
  end
end

class DistributionListsController < ApplicationController
  include DistributionListsHelper
  helper_method :sort_direction, :sort_column
  before_filter :modify_email_ids_param, only: [:create, :update]

  def index
    @distribution_lists = DistributionList.search(params[:search]).order(sort_column + ' ' + sort_direction)
                              .paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @distribution_list = DistributionList.new
  end

  def create
    @distribution_list = DistributionList.new(distribution_list_params)
    if @distribution_list.save
      flash!(:success, locals: { name: @distribution_list.name })
      redirect_to distribution_lists_path
    else
      flash_now!(error: @distribution_list.errors.full_messages.join("<br/>").html_safe)
      render('new')
    end
  end

  def edit
    @distribution_list = DistributionList.find(params[:id])
  end

  def update
    @distribution_list = DistributionList.find(params[:id])
    if @distribution_list.update_attributes(distribution_list_params)
      flash!(:success, locals: { name: @distribution_list.name })
      redirect_to distribution_lists_path
    else
      flash_now!(error: @distribution_list.errors.full_messages.join("<br/>").html_safe)
      render('new')
    end
  end

  def destroy
    @distribution_list = DistributionList.find(params[:id])
    if @distribution_list.destroy
      flash!(:success, locals: { name: @distribution_list.name })
      redirect_to distribution_lists_path
    else
      flash_now!(error: @distribution_list.errors.full_messages.join("<br/>").html_safe)
    end
  end

  private

  # Method to return the column to be used for sorting
  # if sort column param is invalid, we sort by id
  # @return   column to be used for sorting
  def sort_column
    DistributionList.column_names.include?(params[:sort]) ? params[:sort] : 'distribution_lists.id'
  end

  # Method to modify the params hash on create and update actions. See create_extra_mails comment
  # @return   modified params hash
  def modify_email_ids_param
    create_extra_emails(params)
  end

  def distribution_list_params
    params.require(:distribution_list).permit(:name, email_ids: []) # TODO- Add additional emails
  end
end

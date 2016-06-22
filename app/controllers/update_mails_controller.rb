class UpdateMailsController < ApplicationController
  helper_method :sort_direction, :sort_column, :self_search
  before_action :authenticate_user!
  before_action :allowed_to_modify, only: [:edit, :update, :send_email, :destroy]
  before_action :allowed_to_view, only: [:view]

  def index
    search_service = UpdateMailSearchService.new
    @update_mails = search_service.search(params[:search], current_user, self_search)
                                  .order('update_mails.' + sort_column + ' ' + sort_direction('desc') + ' NULLS LAST')
                                  .paginate(page: params[:page], per_page: 25)
  end

  def view
    @update_mail = UpdateMail.find(params[:id])
  end

  def new
    @update_mail = current_user.update_mails.build
  end

  def statistics
    @update_mail = UpdateMail.find(params[:id])
  end

  def create
    @update_mail = current_user.update_mails.build(update_mail_params)
    if @update_mail.save
      flash!(:success, locals: { title: @update_mail.title })
      render js: "window.location = '#{update_mails_path}'"
    else
      respond_to do |format|
        format.js {
          flash!(error: @update_mail.errors.full_messages.join('<br/>').html_safe)
          render js: "window.location = '#{new_update_mail_path}'"
        }
      end
    end
  end

  def edit
    @update_mail = UpdateMail.find(params[:id])
  end

  def update
    @update_mail = UpdateMail.find(params[:id])
    if @update_mail.update_attributes(update_mail_params)
      flash!(:success, locals: { title: @update_mail.title })
      render js: "window.location = '#{update_mails_path}'"
    else
      respond_to do |format|
        format.js {
          flash!(error: @update_mail.errors.full_messages.join('<br/>').html_safe)
          render js: "window.location = '#{edit_update_mail_path(@update_mail)}'"
        }
      end
    end
  end

  def destroy
    @update_mail = UpdateMail.find(params[:id])
    if @update_mail.destroy
      flash!(:success, locals: { title: @update_mail.title })
      redirect_to update_mails_path
    else
      flash_now!(error: @update_mail.errors.full_messages.join('<br/>').html_safe)
    end
  end

  def send_email
    @update_mail = UpdateMail.find(params[:id])
    if UpdateMailMailer.send_mail(@update_mail).deliver
      flash!(:success, locals: { title: @update_mail.title })
      @update_mail.update_attributes(sent: true, sent_at: Time.now)
      redirect_to update_mails_path
    else
      flash_now!(:error)
      render('index')
    end
  end

  private

  # Method to return the column to be used for sorting
  # if sort column param is invalid, we sort by id
  # @return   column to be used for sorting
  def sort_column
    UpdateMail.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def update_mail_params
    params.require(:update_mail).permit(:title, :body, :public, distribution_list_ids: [])
  end

  # Checks if the current user is allowed to modify an update mail
  # if the user is admin or creator of the update mail he is allowed
  # else he will be redirected to the overview
  def allowed_to_modify
    unless UpdateMail.find(params[:id]).user_id == current_user.id || current_user.admin?
      flash!(error: 'Action not allowed!')
      redirect_to update_mails_path
    end
  end

  # Checks if the current user is allowed to view an update mail
  # if the mail is public OR belongs to the user OR the user is admin then the user is allowed to view
  # else he will be redirected to the overview
  def allowed_to_view
    @update_mail = UpdateMail.find(params[:id])
    if @update_mail.public == false && !(@update_mail.user_id == current_user.id || current_user.admin?)
      flash!(error: 'Action not allowed!')
      redirect_to update_mails_path
    end
  end
end

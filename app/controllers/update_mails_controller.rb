class UpdateMailsController < ApplicationController
  helper_method :sort_direction, :sort_column

  def index
    @update_mails = UpdateMail.search(params[:search]).order(sort_column + ' ' + sort_direction)
                              .paginate(page: params[:page], per_page: 25)
  end

  def new
    @update_mail = UpdateMail.new
  end

  def create
    @update_mail = UpdateMail.new(update_mail_params)
    if @update_mail.save
      flash!(:success, locals: { title: @update_mail.title })
      redirect_to update_mails_path
    else
      flash_now!(error: @update_mail.errors.full_messages.join('<br/>').html_safe)
      render('new')
    end
  end

  def edit
    @update_mail = UpdateMail.find(params[:id])
  end

  def update
    @update_mail = UpdateMail.find(params[:id])
    if @update_mail.update_attributes(update_mail_params)
      flash!(:success, locals: { title: @update_mail.title })
      redirect_to update_mails_path
    else
      flash_now!(error: @update_mail.errors.full_messages.join('<br/>').html_safe)
      render('new')
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

  private

  # Method to return the column to be used for sorting
  # if sort column param is invalid, we sort by id
  # @return   column to be used for sorting
  def sort_column
    UpdateMail.column_names.include?(params[:sort]) ? params[:sort] : 'update_mails.id'
  end
end

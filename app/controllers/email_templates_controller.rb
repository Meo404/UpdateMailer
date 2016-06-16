class EmailTemplatesController < ApplicationController
  helper_method :sort_direction, :sort_column
  before_filter :ensure_json_request, only: [:templates]
  before_action :authenticate_user!

  def index
    @email_templates = EmailTemplate.search(params[:search]).order(sort_column + ' ' + sort_direction)
                                    .paginate(page: params[:page], per_page: 25)
  end

  # Controller action used to retrieve email templates as json
  # if id is provided in the call only the specific record will be retrieved
  # else all records will be retrieved
  # Used by the update email selection window
  def templates
    if params.key?(:id)
      if EmailTemplate.exists?(id: params[:id])
        render json: @email_templates = EmailTemplate.find(params[:id]).to_json
      else
        render nothing: true, status: 404
      end
    else
      render json: @email_templates = EmailTemplate.all.to_json
    end
  end

  def new
    @email_template = EmailTemplate.new
  end

  def create
    @email_template = EmailTemplate.new(email_template_params)
    if @email_template.save
      flash!(:success, locals: { name: @email_template.name })
      redirect_to email_templates_path
    else
      flash_now!(error: @email_template.errors.full_messages.join('<br/>').html_safe)
      render('new')
    end
  end

  def edit
    @email_template = EmailTemplate.find(params[:id])
  end

  def update
    @email_template = EmailTemplate.find(params[:id])
    if @email_template.update_attributes(email_template_params)
      flash!(:success, locals: { name: @email_template.name })
      redirect_to email_templates_path
    else
      flash_now!(error: @email_template.errors.full_messages.join('<br/>').html_safe)
      render('new')
    end
  end

  def destroy
    @email_template = EmailTemplate.find(params[:id])
    if @email_template.destroy
      flash!(:success, locals: { name: @email_template.name })
      redirect_to distribution_lists_path
    else
      flash_now!(error: @email_template.errors.full_messages.join('<br/>').html_safe)
    end
  end

  private

  # Method to validate whether or not the request is a JSON request
  # if it is json request then proceed
  # else render nothing with status code 406
  def ensure_json_request
    return if params[:format] == 'json' || request.headers['Accept'] =~ /json/
    render nothing: true, status: 406
  end

  # Method to return the column to be used for sorting
  # if sort column param is invalid, we sort by id
  # @return   column to be used for sorting
  def sort_column
    EmailTemplate.column_names.include?(params[:sort]) ? params[:sort] : 'email_templates.id'
  end

  def email_template_params
    params.require(:email_template).permit(:name, :template, :preview_image)
  end
end

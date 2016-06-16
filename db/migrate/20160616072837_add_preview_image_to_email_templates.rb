class AddPreviewImageToEmailTemplates < ActiveRecord::Migration
  def change
    add_column :email_templates, :preview_image_id, :string
  end
end

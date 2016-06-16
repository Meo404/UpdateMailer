class UpdateMailView < ActiveRecord::Base
  belongs_to :update_mail, counter_cache: true
end

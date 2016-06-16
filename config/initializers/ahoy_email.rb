# EmailSubscriber Class
# Subscribes to Update Mail Openings and create update mail view entries
class EmailSubscriber
  def open(event)
    @update_mail = UpdateMail.find_by_id(event[:message]['user_id'])

    client = DeviceDetector.new(event[:controller].request.user_agent)

    view_params = {
        :ip => event[:controller].request.remote_ip,
        :user_agent => event[:controller].request.user_agent,
        :browser => client.name,
        :browser_version => client.full_version,
        :os => client.os_name,
        :os_version => client.os_full_version,
        :device_name => client.device_name,
        :device_type => client.device_type
    }

    @update_mail_view = @update_mail.update_mail_views.build(view_params)
    @update_mail_view.save
  end
end

AhoyEmail.subscribers << EmailSubscriber.new


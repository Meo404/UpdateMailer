# EmailSubscriber Class
# Subscribes to Update Mail Openings and create update mail view entries
class EmailSubscriber
  def open(event)
    @update_mail = UpdateMail.find_by_id(event[:message]['user_id'])
    client = Browser.new(event[:controller].request.user_agent)

    view_params = {
        user_agent: event[:controller].request.user_agent,
        browser: client.name,
        browser_version: client.full_version,
        os: client.platform.name,
        os_version: client.platform.name,
        device_name: client.device.name,
        device_type: device_type(client)
    }

    @update_mail_view = @update_mail.update_mail_views.build(view_params)
    @update_mail_view.save
  end

  private

  # Returns the device type for the user agent of the request
  # Device type can be mobile, tablet, desktop or other (consoles, tvs)
  # @return   device type of the request
  def device_type(client)
    if client.device.mobile?
      'mobile'
    elsif client.device.tablet?
      'tablet'
    elsif client.device.console? || client.device.tv?
      'other'
    else
      'desktop'
    end
  end
end

AhoyEmail.subscribers << EmailSubscriber.new



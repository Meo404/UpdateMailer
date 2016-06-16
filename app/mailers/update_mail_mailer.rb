# Update Mail Mailer
# Used to send Update Mails from the Application
class UpdateMailMailer < ActionMailer::Base
  default from: 'Bonial Infomailer <infomail@kaufda.de>'

  def send_mail(update_mail)
    @update_mail = update_mail
    to = ''

    @update_mail.distribution_lists.each do |dlist|
      dlist.emails.each do |email|
        to += email.address + ','
      end
    end

    # Allows opening tracking by the Ahoy Email gem
    track user: @update_mail
    track utm_params: false

    mail to: to,
         from: 'Bonial Infomailer <infomail@kaufda.de>',
         subject: @update_mail.title
  end
end

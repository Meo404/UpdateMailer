class MockDataService
  # Function to create mock data set.
  # Creates: emails, distribution lists, update mails, update mail views
  def self.create_data
    create_emails
    create_distribution_lists
    create_update_mails
    create_views
  end

  # Function to create 250 mock emails.
  def self.create_emails
    (1..250).each do
      Email.create(address: Faker::Internet.email)
    end
  end

  # Function to create 150 mock distribution lists.
  # Each distribution lists will hold 1 to 10 emails at random.
  def self.create_distribution_lists
    (1..150).each do
      emails = []
      (1..rand(1..10)).each do
        emails << Email.offset(rand(Email.count)).first.id
      end
      DistributionList.create(name: Faker::Company.name, email_ids: emails)
    end
  end

  # Function to create 100 mock update mails
  def self.create_update_mails
    (1..100).each do
      distribution_lists = []
      (1..rand(1..4)).each do
        distribution_lists << DistributionList.offset(rand(DistributionList.count)).first.id
      end

      sent = [true, false].sample
      created_at = Faker::Time.between(30.days.ago, 7.days.ago, :all)
      sent_at = sent ? Faker::Time.between(created_at, Time.now, :all) : ''
      UpdateMail.create(
                    title: Faker::App.name,
                    body: Faker::Lorem.paragraph,
                    distribution_list_ids: distribution_lists,
                    sent: sent,
                    sent_at: sent_at,
                    public: [true, false].sample,
                    created_at: created_at
      )
    end
  end

  # Function to create in between 1 to 200 update mail views for each update mail that has sent = true
  def self.create_views
    device_types = %w(desktop tablet phablet smartphone)
    operating_systems = %w(Windows Mac Android iOS)

    UpdateMail.find_each do |update_mail|
      if update_mail.sent
        rand(1..200).times do
          view_params = {
              ip: Faker::Internet.ip_v4_address,
              os: operating_systems.sample,
              device_type: device_types.sample,
              created_at: Faker::Time.between(7.days.ago, Time.now, :all)
          }
          update_mail.update_mail_views.create(view_params)
        end
      end
    end
  end
end

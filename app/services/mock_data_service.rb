class MockDataService
  # Function to create mock data set.
  # Creates: emails & distribution lists.
  def self.create_data
    create_emails
    create_distribution_lists
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
end

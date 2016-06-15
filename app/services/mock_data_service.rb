class MockDataService

  def self.create_data
    create_emails
    create_distribution_lists
  end

  def self.create_emails
    (1..250).each do |n|
      Email.create(:address => Faker::Internet.email)
    end
  end

  def self.create_distribution_lists
    (1..150).each do
      emails = []
      (1..rand(1..10)).each do
        emails << Email.offset(rand(Email.count)).first.id
      end

      DistributionList.create(:name => Faker::Company.name, :email_ids => emails)
    end
  end

end
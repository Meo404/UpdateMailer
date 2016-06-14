require 'rails_helper'

RSpec.describe DistributionList, type: :model do
  context 'maillist validity' do
    before :all do
      create(:email, address: 'testmail@updatemailer.de')
      create(:email, address: 'testmail2@updatemailer.de')
    end
    it 'is valid with a name and email address' do
      expect(build(:distribution_list, email_ids: [1])).to be_valid
    end
    it 'is valid with a name and several email addresses' do
      expect(build(:distribution_list, email_ids: [1, 2])).to be_valid
    end
    it 'is invalid without a name' do
      expect(build(:distribution_list, name: nil, email_ids: [1])).to_not be_valid
    end
    it 'is invalid without a email' do
      expect(build(:distribution_list, email_ids: [])).to_not be_valid
    end
    it 'is invalid if name is not unique' do
      create(:distribution_list, name: 'test', email_ids: [1])
      expect(build(:distribution_list, name: 'test', email_ids: [1])).to_not be_valid
    end
  end
  context 'before destroy' do
    it 'cleans associations to emails' do
      create(:email)
      dlist = create(:distribution_list, email_ids: [1])
      expect { dlist.destroy }.to change { dlist.emails.count }.by(-1)
    end
  end
end

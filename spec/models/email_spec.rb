require 'rails_helper'

RSpec.describe Email, type: :model do
  context 'email validity' do
    it 'is valid with valid email address' do
      expect(build(:email)).to be_valid
    end
    it 's invalid with a email address > 250 characters' do
      email = 'test@' + Faker::Lorem.characters(250) + '.de'
      expect(build(:email, address: email)).to_not be_valid
    end
    it 'is invalid with a email address that does not match regex' do
      expect(build(:email, address: 'test@de')).to_not be_valid
      expect(build(:email, address: 'äöü@test.de')).to_not be_valid
    end
    it 'is invalid if email is not unique' do
      create(:email)
      expect(build(:email)).to_not be_valid
    end
    it 'is invalid if no address is given' do
      expect(build(:email, address: '')).to_not be_valid
    end
  end

  context 'before save' do
    it 'downcases email input' do
      email = create(:email, address: 'TEST@TEST.DE')
      expect(email.address).to eq('test@test.de')
    end
  end

  context 'before destroy' do
    it 'cleans association to maillists' do
      email = create(:email)
      dlist = DistributionList.create(name: 'test', email_ids: [email.id])
      expect { email.destroy }.to change { dlist.emails.count }.by(-1)
    end
  end
end

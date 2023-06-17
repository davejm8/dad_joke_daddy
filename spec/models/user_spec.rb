require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it { should validate_presence_of(:phone_number) }
  end
end

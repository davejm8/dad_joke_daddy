require 'rails_helper'

RSpec.describe RapidService, type: :service do
  describe '#instance methods', :vcr do
    describe "#get_dad_joke" do
      it "returns a dad joke" do
        joke = RapidService.new.get_dad_joke

        expect(joke).to be_a(String)
      end
    end
  end
end
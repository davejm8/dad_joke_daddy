require 'rails_helper'

RSpec.describe IcanhasdadjokesService, type: :service do
  describe '#instance methods', :vcr do
    describe "#get_dad_joke" do
      it "returns a dad joke" do
        joke = IcanhasdadjokesService.new.get_joke

        expect(joke).to be_a(String)
      end
    end
  end
end
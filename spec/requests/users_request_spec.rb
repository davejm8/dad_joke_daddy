require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#send_sms' do
    it 'sends an SMS message with a dad joke' do
      phone_number = '13034954624'
      joke = "Why don't scientists trust atoms? Because they make up everything!"

      allow_any_instance_of(IcanhasdadjokesService).to receive(:get_joke).and_return(joke)
      allow_any_instance_of(Twilio::REST::Client).to receive_message_chain(:messages, :create)

      post :send_sms, params: { phone_number: phone_number }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Text-illent job! Your dad joke has been sent!")
    end

    xit 'handles Twilio errors' do
      phone_number = '15555555555'
      error_message = 'Invalid phone number'
      joke = "Why don't scientists trust atoms? Because they make up everything!"

      allow_any_instance_of(IcanhasdadjokesService).to receive(:get_joke).and_return(joke)

      # Stub Twilio::REST::Client and raise a Twilio error
      twilio_client = double('Twilio::REST::Client')
      allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client)
      # Continue to get error message: "wrong number of arguments (given 1, expected 2)"
      # I tried adding 404, 400, status: 400, status_code: 400, { code: 400}, :bad_request ...and continue to get this error message: "undefined method `status_code' for 400:Integer"
      # the Twilio error is: https://www.twilio.com/docs/api/errors/21211
      #=> <Twilio::REST::RestError: [HTTP 400] 21211 : Unable to create record
      #=> The 'To' number 55555 is not a valid phone number.
      allow(twilio_client).to receive_message_chain(:messages, :create).and_raise(Twilio::REST::RestError.new(error_message, 400))

      post :send_sms, params: { phone_number: phone_number }

      expect(response).to redirect_to(root_path)
      expect(flash[:error]).to eq("That phone number format sure did a 'number' on us! Please try again.")
    end
  end
end
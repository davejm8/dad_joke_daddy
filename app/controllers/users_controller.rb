class UsersController < ApplicationController
  def new
  end

  def send_sms
    phone_number = params[:phone_number]
    joke = IcanhasdadjokesService.new.get_joke
    # Use Twilio to send the joke to the provided phone number
    send_sms_message(phone_number, joke)

    redirect_to root_path, notice: "Text-illent job! Your dad joke has been sent!"

  rescue Twilio::REST::RestError => e
    flash[:error] = "That phone number format sure did a 'number' on us! Please try again."
    redirect_to root_path # replace this with your error path
  end

  private

  def send_sms_message(phone_number, message)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_API_KEY'])

    client.messages.create(
      from: '+18448459414', 
      to: phone_number,
      body: message
    )
  end
end
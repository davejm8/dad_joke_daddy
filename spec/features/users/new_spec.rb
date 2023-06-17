require 'rails_helper'

RSpec.describe 'root', type: :feature do
  describe 'happy path', :vcr do
    it 'has a form to send an SMS message' do
      visit root_path

      expect(page).to have_field('Phone number')
      expect(page).to have_button('Prepare for Pun-ishment!')
    end

    it 'sends an SMS message' do
      visit root_path

      fill_in 'Phone number', with: '12078310173'
      click_button 'Prepare for Pun-ishment!'

      expect(page).to have_content('Text-illent job! Your dad joke has been sent!')
    end
  end
end
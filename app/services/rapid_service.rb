class RapidService

  def get_dad_joke
    response = conn.get
    joke = JSON.parse(response.body, symbolize_names: true)
    joke[:body][0][:setup] + "\n\n\n" + joke[:body][0][:punchline]
  end

  private
  
  def conn
    Faraday.new(
      url: 'https://dad-jokes.p.rapidapi.com/random/joke',
      headers: {
        'X-RapidAPI-Key': ENV['RAPID_API_KEY'],
        'X-RapidAPI-Host': 'dad-jokes.p.rapidapi.com'
      }
    )
  end
end
class IcanhasdadjokesService
  def get_joke
    response = conn.get

    joke_response = JSON.parse(response.body, symbolize_names: true)
    joke_response[:joke]
  end

  private
  def conn
    Faraday.new(
      url: 'https://icanhazdadjoke.com/',
      headers: {
        'Accept': 'application/json'
      }
    )
  end
end
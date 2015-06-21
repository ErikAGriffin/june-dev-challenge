require 'net/http'

class HTTPHandler

  def self.get_url(url)
    response = Net::HTTP.get_response(URI(url))
    case response
    when Net::HTTPSuccess then
      response.body
    when Net::HTTPRedirection then
      location = response['location']
      get_url(location)
    else
      response.value
    end
  end

end

require 'sinatra'
require 'json'
require 'pony'

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
}

put '/email' do
  email = params[:email]
  js = JSON.parse(request.body.read)
  if !js.empty? && js['data'] && !js['data'].empty?
    Pony.mail(
      to: email,
      from: "td2mail <noreply@treasure-data.com>",
      subject: "[Treasure Data] Email Alert",
      body: "Body: #{js.to_s}"
    )
  end
end

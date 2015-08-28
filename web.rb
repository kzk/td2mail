require 'sinatra'
require 'json'

put '/email' do
  email = params[:email]
  js = JSON.parse(request.body.read)
  puts js
  if !js.empty? && js['data']
    puts 'send!'
  end
  'ok'
end

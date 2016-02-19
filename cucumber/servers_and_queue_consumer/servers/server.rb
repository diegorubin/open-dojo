require "sinatra"

get '/api/:name' do
  f = File.open("files/#{params[:name]}")
  f.read
end

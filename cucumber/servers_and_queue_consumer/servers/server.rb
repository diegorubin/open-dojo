require "sinatra"

get '/api/:name' do
  content_type 'plain/text'
  content = File.open("files/#{params[:name]}").read
  puts content
  content
end

require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/music' do

  erb :music

end




get '/' do
  erb "Всiм привiт!"
  
end

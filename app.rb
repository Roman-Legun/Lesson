require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb "Всiм привiт!"
  
end

get '/music' do

  erb :music

end

get '/users' do

  erb :users

end

post '/users' do

  erb :users

  end
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

  @user_name = params[:user_name]
  @user_name2 = params[:user_name2]
  @phone = params[:phone]
  @date = params[:date]
  @master = params[:master]
  @color = params[:color]

  erb "OK #{@user_name} #{@user_name2} ми радi що ви в нас зарегiструвалися!      
  Наш майстер #{@master} буде вас чекати на: #{@date} #{@color}"


end
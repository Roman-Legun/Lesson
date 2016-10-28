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

get '/kino' do
  @error = "сторiнка поки що не доступна!!!"
  erb :kino
end

post '/users' do

  @user_name = params[:user_name]
  @user_name2 = params[:user_name2]
  @phone = params[:phone]
  @date = params[:date]
  @master = params[:master]
  @color = params[:color]

  hh = {
    :user_name => "Введiть ваше iм'я!",
    :user_name2 => "Введiть вашу фамiлiю!",
    :phone => "Введiть ваш номер телефону!",
    :date => "Введiть вашу дату регiстрацii!",
    :color => "Введiть ваш  колiр!"
  }
  hh.each do |key,value|
    if params[key] == ""
      @error = hh[key]
      return erb :users
    end
  end

  erb "OK #{@user_name} #{@user_name2} ми радi що ви в нас зарегiструвалися!      
  Наш майстер #{@master} буде вас чекати на: #{@date} #{@color}"


end
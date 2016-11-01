require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_master_exists? db, name
  db.execute('select * from masters where Name=?', [name]).length > 0
end

def seed_db db, masters
  masters.each do |master|
    if !is_master_exists? db, master
      db.execute 'insert into masters (Name) values (?)', [master]
    end
  end
end

def get_db
  db = SQLite3::Database.new "shop.db"
  db.results_as_hash = true
  return db
end

before do
  db = get_db
  @masters = db.execute 'select * from masters'
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS "users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "Name" TEXT,
  "Last_name" TEXT,
  "Phone" INTEGER,
  "Date" INTEGER,
  "Master" TEXT,
  "Color" TEXT
  )'
  db.execute 'CREATE TABLE IF NOT EXISTS "posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "Date" DATE,
  "Content" TEXT
  )'
  db.execute 'CREATE TABLE IF NOT EXISTS "masters" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "Name" TEXT  
  )'

  seed_db db, ["Коля Ткачук", "Леся Дузiнкевич", "Роман Човганюк", "Орест Калиновський", "Богдан Ткаченко"]

end

get '/' do
  erb "Всiм привiт!"
  
end

get '/posts' do

  db = get_db
  @resultss = db.execute 'select * from posts order by id desc'
  erb :posts

end

get '/users' do

  erb :users

end

get '/new_post' do
  erb :new_post
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

  db = get_db
  db.execute 'insert into users(
  Name,
  Last_name,
  Phone,
  Date,
  Master,
  Color
  )
  values (?, ?, ?, ?, ?, ?)', [@user_name, @user_name2, @phone, @date, @master, @color]

  erb "OK #{@user_name} #{@user_name2} ми радi що ви в нас зарегiструвалися!      
  Наш майстер #{@master} буде вас чекати на: #{@date} #{@color}"

end

post '/new_post' do 
  db = get_db
  @content = params[:content]
  if @content.length == 0
    @error = "Введiть текст!"
    return erb :new_post
  end
  db.execute 'insert into posts (Content, Date) values (?, datetime())', [@content]
  erb"Ваш пост був успiшно доданий!"
end

get '/show_users' do
  db = get_db
  @results = db.execute 'select * from users order by id desc'
  erb :show_users
end


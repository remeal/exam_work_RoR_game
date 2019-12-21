class MainController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def game
    @image = rand(1..10)
    cookies[:someval] = @image
  end

  # Вывод результата игры и подсчет баллов
  def result
   @name = Image.find_by_number(cookies[:someval])[:name]
   @lat = Image.find_by_number(cookies[:someval])[:lat].to_f
   @lng = Image.find_by_number(cookies[:someval])[:lng].to_f
   @latcor = flash[:latcor].to_f
   @lngcor = flash[:lngcor].to_f
   @distance = distance(@lat, @lng, @latcor, @lngcor)
   @score = score(@distance)
   cookies[:score] = @score
   list
  end

  # Получение отмеченных пользователем координат
  def getcoordinate
    flash[:latcor] = params[:lat]
    flash[:lngcor] = params[:lng]
  end

  #Вывод рейтинга
  def rank
    @users = User.all.order(score: :desc)
  end

private

  # Расчет расстояния между координатами
  def distance(lat1,lng1,lat2,lng2) #
   dlat = deg2rad(lat2 - lat1)
   dlng = deg2rad(lng1 - lng2)
   d = Math.sin(dlat/2)**2 + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2))* Math.sin(dlng)**2
   ((2 * Math.atan2(Math.sqrt(d), Math.sqrt(1-d))) * 6371).round(3)
  end

  # Подсчет баллов
  def score(distance)
    (1000 - 0.1 * distance).to_i
  end

  def deg2rad(deg)
    deg * (3.14/180)
  end

  # Добавление баллов в бд
  def list
    if current_user.score.nil?
      User.find_by_email(current_user.email).update(score: cookies[:score])
    else
      d = User.find_by_email(current_user.email)[:score]
      User.find_by_email(current_user.email).update(score: (cookies[:score].to_i + d))
    end
  end

end

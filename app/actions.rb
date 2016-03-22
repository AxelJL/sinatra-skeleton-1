# Homepage (Root path)
helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def logged_in
    session[:user_id]
  end

end


get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/genres' do
  erb :'genres/index'
end

get '/genres/pop' do
  erb :'genres/pop'
end

post '/songs' do
  song = Song.new(
    song_title: params[:song_title],
    artist: params[:artist],
    author: current_user.username,
    genre: params[:genre],
    url: params[:url],
    user_id: current_user.id
  )
  if song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id' do
  song = Song.find params[:id]
  erb :'songs/show'
end

get '/signup' do
  @user = User.new
  erb :'/signup'
end

post '/signup' do
  user = User.new(
    username: params[:username],
    password: params[:password]
  )
  if user.save
    session[:user_id] = user.id
    redirect '/'
  end
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  end
end

delete '/login' do
  session[:user_id] = nil
  redirect "/"
end

put '/likes' do
  song = Song.find(id: params[:id])
  song.likes += 1
  song.save
  redirect :'songs'
end

# post '/dislike' do

# end






















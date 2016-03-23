helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def logged_in
    session[:user_id]
  end

  def already_reviewed(song)
    !song.reviews.where(user_id: current_user.id).empty?
    # !Review.where(user_id: current_user.id, song_id: song.id).empty?
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
  @song = Song.find(params[:id])
  @reviews = Review.where(song_id: @song)
  erb :'songs/show'
end

post '/review' do
  review = Review.new(
    review: params[:review],
    user_id: current_user.id,
    song_id: params[:song_id]
    )
  review.save
  redirect "/songs/#{params[:song_id]}"
end

delete '/review/:id' do
  review = Review.find(params[:id])
  review.destroy
  redirect back
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
  else
    session[:alert] = "Please try again."
    redirect back
  end
end

delete '/login' do
  session[:user_id] = nil
  redirect "/"
end

post '/likes' do
  Upvote.create(user_id: session[:user_id], song_id: params[:song_id])
  redirect "/songs"
end























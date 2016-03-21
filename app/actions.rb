# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    song_title: params[:song_title],
    artist: params[:artist],
    author: params[:author],
    url: params[:url]
  )
  @song.save
  redirect '/songs'
end
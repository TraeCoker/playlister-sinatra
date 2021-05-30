require 'rack-flash'
class SongsController < ApplicationController 
    enable :sessions
    use Rack::Flash

    get '/songs' do 
        @songs = Song.all 
        erb :'songs/index'
    end 

    get '/songs/new' do 
        @artists = Artist.all
        @genres = Genre.all 
        
        erb :'songs/new'
    end 

    post '/songs' do 
        @song = Song.create(name: params[:name])
        @song.artist = Artist.find_or_create_by(name: params[:artist_name])
        if !params[:genres].empty?
            params[:genres].each do |genre_id|
             @song.genres << Genre.find(genre_id)
            end 
        end 
        @song.save 

        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end 

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])

        erb :'songs/show'
    end 

     get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all 
        erb :'songs/edit'
    end 

    patch '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        if !params[:artist_name].empty?
        @song.artist = Artist.find_or_create_by(name: params[:artist_name])
        end 
        if !params[:name].empty?
            @song.name = params[:name]
        end 
        if !params[:genres].empty?
            @song.genres.clear &&
            params[:genres].each do |genre_id|
             @song.genres << Genre.find(genre_id)
            end 
        end 
        @song.save 

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end
    

end 
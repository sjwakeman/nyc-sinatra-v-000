class LandmarksController < ApplicationController

  get '/landmarks' do
     @landmarks = Landmark.all
     erb :'landmarks/index'
   end

   get '/landmarks/new' do
     erb :'landmarks/new'
   end

   post "/landmarks/new" do
     Landmark.find_or_create_by(params["landmark"])
     erb :"/landmarks"
   end
   #post '/landmarks' do
     #@landmark = Landmark.create(:name => params["Name"])
     #@landmark.figure = Figure.find_or_create_by(:name => params["Figure Name"])
     #@landmark.title_ids = params[:titles]
     #@landmark.save
     #flash[:message] = "Successfully created landmark."
     #redirect("landmarks/#{@landmark.id}") #("landmarks/#{@landmark.slug}")
   #end

   post '/landmarks' do
     @landmark = Landmark.new(params[:landmark])
     unless params[:landmark][:name].empty?
       @landmark = Landmark.create(params[:landmark])
       @landmark.name << @landmark
     end
     #unless params[:landmark][:name].empty?
       #@landmark = Landmark.create(params[:landmark])
       #@figure.landmarks << @landmark
     #end
     @landmark.save
     redirect to "/landmarks/#{@landmark.id}"
   end

   get '/landmarks/:id' do
     @landmark = Landmark(oarams[:id])#@landmark = Landmark.find_by_slug(params[:slug])
     erb :'landmarks/show'
   end

   get '/landmarks/:id/edit' do
     @landmark = Landmarks(params[:id]) #@landmark = Landmarks.find_by_slug(params[:slug])
     erb :'landmarks/edit'
   end

   patch '/landmarks/:id' do

     @landmark = Landmarks(params[:id]) #@landmark = Landmarks.find_by_slug(params[:slug])
     @landmark.save(params[:landmark])
     @landmark.figure = Figures.find_or_create_by(name: params[:figure][:name])
     @landmark.save
     flash[:message] = "Successfully updated landmark."
     erb :'landmarks/show'
   end
 end

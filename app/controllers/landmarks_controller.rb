class LandmarksController < ApplicationController

  get '/landmarks' do
     @landmarks = Landmark.all
     erb :'landmarks/index'
   end

   get '/landmarks/new' do
     erb :'landmarks/new'
   end

   post '/landmarks' do
     @landmark = Landmark.create(:name => params["Name"])
     @landmark.figure = Figure.find_or_create_by(:name => params["Figure Name"])
     @landmark.title_ids = params[:titles]
     @landmark.save
     flash[:message] = "Successfully created landmark."
     redirect("landmarks/#{@landmark.id}") #("landmarks/#{@landmark.slug}")
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

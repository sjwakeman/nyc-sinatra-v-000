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
     redirect("landmarks/#{@landmark.name}") #("landmarks/#{@landmark.slug}")
   end

   get '/landmarks/:slug' do
     @landmark = Landmark.name #@landmark = Landmark.find_by_slug(params[:slug])
     erb :'landmarks/show'
   end

   get '/landmarks/:slug/edit' do
     @landmark = Landmarks.find_by_slug(params[:slug]) #@landmark = Landmarks.find_by_slug(params[:slug])
     erb :'landmarks/edit'
   end

   patch '/landmarks/:slug' do

     @landmark = Landmarks.find_by_slug(params[:slug]) #@landmark = Landmarks.find_by_slug(params[:slug])
     @landmark.save(params[:landmark])
     @landmark.figure = Figures.find_or_create_by(name: params[:figure][:name])
     @landmark.save
     flash[:message] = "Successfully updated landmark."
     erb :'landmarks/show'
   end
 end

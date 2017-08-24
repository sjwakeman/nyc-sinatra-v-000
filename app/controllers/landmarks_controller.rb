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
     if @landmark = Landmark.find(params[:id]) #:landmark
       erb :'landmarks/show'
     else
       erb :"/landmarks", locals: { message: "I didn't find a matching landmark."}
     end
   end

   get '/landmarks/:id/edit' do
     if @landmark = Landmark.find(params[:id])
       #@landmarks = Landmark.all
       #@year_completed = Year_Completed.all #@year_completed = @landmarks.year_completed
       erb :'landmarks/edit'
     else
       erb :"/landmarks", locals: { message: "I didn't find a matching landmark."}
     end
   end

   patch '/landmarks/:id' do
     @landmark = Landmarks.find(params[:id])
     @landmark.save(params[:landmark])
     @landmark.figure = Figures.find_or_create_by(name: params[:figure][:name])
     @landmark.save
     flash[:message] = "Successfully updated landmark."
     redirect to 'landmarks/show'
   end
 end

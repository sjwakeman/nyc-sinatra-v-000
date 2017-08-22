class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  post "/figures/new" do
    Figure.find_or_create_by(params["figure"])
    erb :"/figures"
  end

  post '/figures' do
    @figure = Figure.new(params[:figure])
    unless params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    unless params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end
    @figure.save
    erb :'/figures'
  end

  #post '/figures' do
    #@figure = Figure.create(:name => params["Name"])
    #@figure.landmark = Landmark.find_or_create_by(:name => params["Landmark Name"])
    #@figure.title_ids = params[:title]
    #@figure.save
    #flash[:message] = "Successfully created figure."
    #redirect("figures/#{@figure.id}") #("gigures/#{@figure.slug}")
  #end

  #get "/figures/:id" do
    #@figure = Figure(params[:id]) #igure.find_by_slug(params["slug"])
  #erb :"/figures/show"
  #end

end

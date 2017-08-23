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
    erb :"/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    erb :'figures/show'
    @figure = Figure.find(params[:id])
  end

end

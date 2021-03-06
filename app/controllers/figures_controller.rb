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
    redirect to "/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    if @figure = Figure.find(params[:id])
      erb :"/figures/show"
    else
      erb :"/figures", locals: { message: "I didn't find a matching figure."}
    end
  end

  post "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    @landmark = Landmark.find(:id)
    @landmark.update(params[:landmark])
    redirect to "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    if @figure = Figure.find(params[:id])
      @landmarks = Landmark.all
      @titles = Title.all
      erb :"/figures/edit"
    else
      erb :"/figures", locals: { message: "I didn't find a matching figure."}
    end
  end
end

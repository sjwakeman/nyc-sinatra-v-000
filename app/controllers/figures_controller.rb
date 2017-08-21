class FiguresController < ApplicationController

  get '/figures/new' do
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.create(:name => params["Name"])
    @figure.landmark = Landmark.find_or_create_by(:name => params["Landmark Name"])
    @figure.title_ids = params[:titles]
    @figure.save
    flash[:message] = "Successfully created figure."
    redirect("figures/#{@figure.id}") #("gigures/#{@figure.slug}")
  end

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/:id" do
    @figure = Figure(params[:id]) #igure.find_by_slug(params["slug"])
    erb :"/figures/show"
  end
end

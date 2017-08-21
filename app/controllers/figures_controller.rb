class FiguresController < ApplicationController

  get '/figures/new' do
    erb :"figures/new"
  end

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/:slug" do
    @figure = Figure.name #igure.find_by_slug(params["slug"])
    erb :"/figures/show"
  end
end

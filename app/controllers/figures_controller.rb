require "pry"
class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    new_title = Title.new(params[:title])
    new_landmark = Landmark.new(params[:landmark])

    if !new_title.name.empty?
      new_title.save
      @figure.title_ids = new_title.id
    end

    if !new_landmark.name.empty?
      new_landmark.save
      @figure.landmark_ids = new_landmark.id
    end

    @figure.save

    erb :'figures/show'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params[:figure][:name]

    new_title = Title.new(params[:title])
    new_landmark = Landmark.new(params[:landmark])

    if !new_title.name.empty?
      new_title.save
      @figure.title_ids = new_title.id
    end

    if !new_landmark.name.empty?
      new_landmark.save
      @figure.landmark_ids = new_landmark.id
    end

    @figure.save
    erb :"figures/show"
  end
end
# frozen_string_literal: true
require_relative '../../config/environment'

# Main Controller
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  delete '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.destroy
    redirect '/articles'
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  post '/articles' do
    redirect "/articles/#{Article.find_or_create_by(params).id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles' do
    article = Article.find_by_id(params['id'])
    article.title = params[:title]
    article.content = params[:content]
    article.save
    redirect "/articles/#{article.id}"
  end
end

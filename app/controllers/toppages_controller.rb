class ToppagesController < ApplicationController
  def index
      @articles = Article.order(id: :desc).page(params[:page])
  end
end

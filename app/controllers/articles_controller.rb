class ArticlesController < ApplicationController
 before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
 before_action :correct_user, only: [:edit,:update,:destroy]
  
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private

  # Strong Parameter
  def article_params
    params.require(:article).permit(:content,:title)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
end

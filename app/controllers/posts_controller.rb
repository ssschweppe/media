class PostsController < ApplicationController
  # На сайте только опубликованные посты. Черновики и архив видны в админке
  def index
    @posts = Post.published.latest.includes(:rubric, :category)
  end

  def show
    @post = Post.published.find_by!(slug: params.expect(:slug))
  end
end

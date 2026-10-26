class PostsController < ApplicationController
  # На сайте только опубликованные посты. Черновики и архив видны в админке
  def index
    @posts = Post.published.latest.includes(:rubric, :category)
  end

  # Черновик по прямой ссылке не откроется: find_by! даст 404
  def show
    @post = Post.published.find_by!(slug: params.expect(:slug))
  end
end

class HomeController < ApplicationController
  # Заглушка до запуска. Если уже есть опубликованные посты, показываем последние
  def index
    @posts = Post.published.latest.includes(:rubric, :category).limit(3)
  end
end

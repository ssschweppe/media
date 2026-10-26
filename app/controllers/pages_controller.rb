class PagesController < ApplicationController
  # Разбор строительной компании: на него ведёт кнопка «Попробовать разбор»
  DEMO_POST_SLUG = "stroitelnaya-kompaniya"

  # Статическая страница, в админке не редактируется.
  # Кнопка показывается, только если разбор опубликован, иначе @demo_post будет nil
  def about
    @demo_post = Post.published.find_by(slug: DEMO_POST_SLUG)
  end
end

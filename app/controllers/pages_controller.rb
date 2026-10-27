class PagesController < ApplicationController
  layout "landing"

  # Статическая страница «О проекте», в админке не редактируется
  def about
  end
end

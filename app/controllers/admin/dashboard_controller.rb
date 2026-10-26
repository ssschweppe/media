class Admin::DashboardController < Admin::BaseController
  def index
    @rubrics_count = Rubric.count
    @categories_count = Category.count
    @posts_by_status = Post.group(:status).count
  end
end

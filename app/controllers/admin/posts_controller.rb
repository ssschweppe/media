class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[ show edit update destroy ]

  # В админке видны все посты: черновики, опубликованные и архив
  def index
    @posts = Post.includes(:rubric, :category).order(created_at: :desc)
    @posts = @posts.where(status: params[:status]) if Post::STATUSES.key?(params[:status])
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_post_path(@post), notice: "Пост создан"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "Пост сохранён"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy!
    redirect_to admin_posts_path, notice: "Пост удалён", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params.expect(:id))
  end

  # cover_cache сохраняет загруженную обложку, если форма вернулась с ошибкой
  def post_params
    params.expect(post: [ :rubric_id, :category_id, :title, :slug, :lead,
                          :cover, :cover_cache, :remove_cover, :body, :status ])
  end
end

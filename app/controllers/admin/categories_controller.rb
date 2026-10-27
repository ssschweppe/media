class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.ordered
  end

  def show
    @posts = @category.posts.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Категория создана"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Категория сохранена"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "Категория удалена", status: :see_other
    else
      redirect_to admin_categories_path, alert: @category.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_category
    @category = Category.find(params.expect(:id))
  end

  def category_params
    params.expect(category: [ :name, :slug, :description, :position ])
  end
end

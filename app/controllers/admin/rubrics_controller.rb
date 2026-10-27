class Admin::RubricsController < Admin::BaseController
  before_action :set_rubric, only: %i[ show edit update destroy ]

  def index
    @rubrics = Rubric.ordered
  end

  def show
    @posts = @rubric.posts.order(created_at: :desc)
  end

  def new
    @rubric = Rubric.new
  end

  def edit
  end

  def create
    @rubric = Rubric.new(rubric_params)

    if @rubric.save
      redirect_to admin_rubrics_path, notice: "Рубрика создана"
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @rubric.update(rubric_params)
      redirect_to admin_rubrics_path, notice: "Рубрика сохранена"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if @rubric.destroy
      redirect_to admin_rubrics_path, notice: "Рубрика удалена", status: :see_other
    else
      redirect_to admin_rubrics_path, alert: @rubric.errors.full_messages.to_sentence, status: :see_other
    end
  end

  private

  def set_rubric
    @rubric = Rubric.find(params.expect(:id))
  end

  def rubric_params
    params.expect(rubric: [ :name, :slug, :description, :position ])
  end
end

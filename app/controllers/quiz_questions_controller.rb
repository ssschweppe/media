class QuizQuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_quiz_question, only: %i[ show edit update destroy ]

  # GET /quiz_questions or /quiz_questions.json
  def index
    @quiz_questions = QuizQuestion.all
  end

  # GET /quiz_questions/1 or /quiz_questions/1.json
  def show
  end

  # GET /quiz_questions/new
  def new
    @quiz_question = QuizQuestion.new
  end

  # GET /quiz_questions/1/edit
  def edit
  end

  # POST /quiz_questions or /quiz_questions.json
  def create
    @quiz_question = QuizQuestion.new(quiz_question_params)

    respond_to do |format|
      if @quiz_question.save
        format.html { redirect_to @quiz_question, notice: "Quiz question was successfully created." }
        format.json { render :show, status: :created, location: @quiz_question }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @quiz_question.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /quiz_questions/1 or /quiz_questions/1.json
  def update
    respond_to do |format|
      if @quiz_question.update(quiz_question_params)
        format.html { redirect_to @quiz_question, notice: "Quiz question was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quiz_question }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @quiz_question.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /quiz_questions/1 or /quiz_questions/1.json
  def destroy
    @quiz_question.destroy!

    respond_to do |format|
      format.html { redirect_to quiz_questions_path, notice: "Quiz question was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_question
      @quiz_question = QuizQuestion.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quiz_question_params
      params.expect(quiz_question: [ :prompt, :justified, :explanation, :breakdown_id ])
    end
end

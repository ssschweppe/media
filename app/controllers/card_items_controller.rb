class CardItemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_card_item, only: %i[ show edit update destroy ]

  # GET /card_items or /card_items.json
  def index
    @card_items = CardItem.all
  end

  # GET /card_items/1 or /card_items/1.json
  def show
  end

  # GET /card_items/new
  def new
    @card_item = CardItem.new
  end

  # GET /card_items/1/edit
  def edit
  end

  # POST /card_items or /card_items.json
  def create
    @card_item = CardItem.new(card_item_params)

    respond_to do |format|
      if @card_item.save
        format.html { redirect_to @card_item, notice: "Card item was successfully created." }
        format.json { render :show, status: :created, location: @card_item }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @card_item.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /card_items/1 or /card_items/1.json
  def update
    respond_to do |format|
      if @card_item.update(card_item_params)
        format.html { redirect_to @card_item, notice: "Card item was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @card_item }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @card_item.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /card_items/1 or /card_items/1.json
  def destroy
    @card_item.destroy!

    respond_to do |format|
      format.html { redirect_to card_items_path, notice: "Card item was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_item
      @card_item = CardItem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def card_item_params
      params.expect(card_item: [ :kind, :text, :position, :breakdown_id, :source_id ])
    end
end

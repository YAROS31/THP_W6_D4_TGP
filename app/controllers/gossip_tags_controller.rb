class GossipTagsController < ApplicationController
  before_action :set_gossip_tag, only: %i[ show edit update destroy ]

  # GET /gossip_tags or /gossip_tags.json
  def index
    @gossip_tags = GossipTag.all
  end

  # GET /gossip_tags/1 or /gossip_tags/1.json
  def show
  end

  # GET /gossip_tags/new
  def new
    @gossip_tag = GossipTag.new
  end

  # GET /gossip_tags/1/edit
  def edit
  end

  # POST /gossip_tags or /gossip_tags.json
  def create
    @gossip_tag = GossipTag.new(gossip_tag_params)

    respond_to do |format|
      if @gossip_tag.save
        format.html { redirect_to gossip_tag_url(@gossip_tag), notice: "Gossip tag was successfully created." }
        format.json { render :show, status: :created, location: @gossip_tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @gossip_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gossip_tags/1 or /gossip_tags/1.json
  def update
    respond_to do |format|
      if @gossip_tag.update(gossip_tag_params)
        format.html { redirect_to gossip_tag_url(@gossip_tag), notice: "Gossip tag was successfully updated." }
        format.json { render :show, status: :ok, location: @gossip_tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gossip_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gossip_tags/1 or /gossip_tags/1.json
  def destroy
    @gossip_tag.destroy

    respond_to do |format|
      format.html { redirect_to gossip_tags_url, notice: "Gossip tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gossip_tag
      @gossip_tag = GossipTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gossip_tag_params
      params.fetch(:gossip_tag, {})
    end
end

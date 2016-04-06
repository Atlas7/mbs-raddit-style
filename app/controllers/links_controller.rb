class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /links
  # GET /links.json
  def index
    #@links = Link.all.order(:cached_votes_score => :desc).limit(2).offset(2)
    #@links = Link.all.order(:cached_votes_score => :desc)
    cat = params[:category]
    if cat
      @links = Link.includes(:category).where(categories: {name: cat})
    else
      @links = Link.all
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])
    if user_signed_in?
      @new_comment = Comment.build_from(@link, current_user.id, "")
    end
  end

  # GET /links/new
  def new
    #@link = Link.new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    #@link = Link.new(link_params)
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new}
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @link.liked_by current_user
    respond_to do |format|
      format.js {render :refresh_votes}
    end
  end

  def downvote
    @link.disliked_by current_user
    respond_to do |format|
      format.js {render :refresh_votes}
    end
  end

  def refresh_votes
    respond_to do |format|
      format.js { }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url, :category_id)
    end
end

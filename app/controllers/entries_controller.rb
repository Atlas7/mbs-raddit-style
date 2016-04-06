class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #@entries = Entry.all
    #@entries = Entry.all.order(:created_at => :desc)
    @entries = Entry.all

    category_name = params[:category_name]
    element_type = params[:element_type]

    @entries = @entries.includes(:category).where(categories: {name: category_name}) if category_name.present?
    @entries = @entries.includes(:entry_element).where(entry_elements: {element_type: element_type}) if element_type.present?
    @entries = @entries.all.order(:created_at => :desc)

  end

  def show
    if user_signed_in?
      @new_comment = Comment.build_from(@entry, current_user.id, "")
    end
  end

  def new
    @entry = current_user.entries.build
    @categories = Category.order(:id)
    @media = Medium.all

    @mind = Category.where(name: "Mind").first
    @body = Category.where(name: "Body").first
    @soul = Category.where(name: "Soul").first

    @mind_media = @mind.media.all
    @body_media = @body.media.all
    @soul_media = @soul.media.all

    @quote = Quote.new
    @picture = Picture.new

  end

  def create
    entry = current_user.entries.build(entry_params)
    medium_name = entry.medium.name
    if medium_name == "Quote"
      quote = Quote.new(quote_params)
      entry.quote = quote
      respond_to do |format|
        if quote.save and entry.save
          format.html { redirect_to root_path, notice: 'Entry and Quote were successfully created.' }
        else
          format.html { render :new, notice: 'An error occurred'}
        end
      end
    elsif medium_name == "Picture"
      picture = Picture.new(picture_params)
      entry.picture = picture
      respond_to do |format|
        if picture.save and entry.save
          format.html { redirect_to root_path, notice: 'Entry and Picture were successfully created.' }
        else
          format.html { render :new, notice: 'An error occurred'}
        end
      end
    else
      flash[:notice] = "error when create entry"
    end
  end

  def upvote
    @entry.liked_by current_user
    respond_to do |format|
      format.js {render :refresh_votes}
    end
  end

  def downvote
    @entry.disliked_by current_user
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
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:category_id, :medium_id)
    end

    def quote_params
        params.require(:quote).permit(:title)
    end

    def picture_params
      params.require(:picture).permit(:title)
    end

end

class Api::V1::EntriesController < Api::V1::BaseController
  include ActiveHashRelation
  before_action :set_entry, only: [:show, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def show
    render(json: Api::V1::EntrySerializer.new(@entry).to_json)
  end

  def index
    @entries = Entry.all
    @entries = apply_filters(@entries, params)

    render(
      json: ActiveModel::ArraySerializer.new(
        @entries,
        each_serializer: Api::V1::EntrySerializer,
        root: 'entries',
      )
    )
  end

  def create
    @entry = current_user.entries.build(entry_params)
    @medium_name = @entry.medium.name
    if @medium_name == "Quote"
      @quote = Quote.new(quote_params)
      @entry.quote = @quote
      if @quote.save and @entry.save
        render(json: Api::V1::EntrySerializer.new(@entry).to_json)
      else
        render(json: api_error("Cant't create a quote entry"))
      end

    elsif @medium_name == "Picture"
      @picture = Picture.new(picture_params)
      @entry.picture = @picture
      if @picture.save and @entry.save
        render(json: Api::V1::EntrySerializer.new(@entry).to_json)
      else
        #render(json:, api_error("An error has occured", error_code=401))
      end
    else
      #render(json:, api_error("Invalid medium", error_code=401))
    end
  end

  def upvote
    @entry.liked_by current_user
    render(json: Api::V1::EntrySerializer.new(@entry).to_json)
  end

  def downvote
    @entry.disliked_by current_user
    render(json: Api::V1::EntrySerializer.new(@entry).to_json)
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
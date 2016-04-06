class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #@pictures = Picture.all
    @pictures = Picture.all.order(:created_at => :desc)
  end

  def show
    @entry = @picture.entry
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @entry = current_user.entries.build
    @entry.picture = @picture
    @entry.category_id = params[:category_id]
    
    respond_to do |format|
      if @picture.save and @entry.save
        format.html {
          redirect_to root_path, notice: 'Entry and Picture were successfully created.'
        }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new}
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @entry = @picture.entry
    @entry.destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Entry and Picture were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:title)
    end
end

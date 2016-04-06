class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    #@quotes = Quote.all
    @quotes = Quote.all.order(:created_at => :desc)
  end

  def show
    @entry = @quote.entry
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    @entry = current_user.entries.build
    @entry.quote = @quote

    respond_to do |format|
      if @quote.save and @entry.save
        format.html {
          redirect_to root_path, notice: 'Entry and Quote were successfully created.'
        }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, notice: 'An error occurred'}
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @entry = @quote.entry
    @entry.destroy
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Entry and Quote were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:title)
    end

end

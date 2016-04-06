class EntryElementsController < ApplicationController
  before_action :set_element, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @entry_elements = EntryElement.all
  end

  def show
    @entry_element = EntryElement.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @entry_element = EntryElement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_element_params
      params.require(:entry_element).permit(:element_type)
    end
end

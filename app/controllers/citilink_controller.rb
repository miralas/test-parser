class CitilinkController < ApplicationController
  def load_file
     Citilink.import(params[:file]) if params[:file]
  end
end

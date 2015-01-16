class CitilinkController < ApplicationController
  def load_file
  	if params[:file] then
	  	path = File.join("public", params[:file].original_filename) 
	  	File.open(path, "wb") { |f| f.write(params[:file].read) }
	    Citilink.import(params[:file].original_filename)
	end

  end
end

class Citilink < ActiveRecord::Base
	def self.import(file)
		spreadsheet = open(file)
		(1..spreadsheet.last_row).each do |f|
			if (!f.nil? || f != "") then
				Citilink.new
				Citilink.supplier_no = f
				Citilink.save!
			end
		end
	end
end

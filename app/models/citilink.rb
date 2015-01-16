require 'csv'

class Citilink < ActiveRecord::Base
	def self.import(file)
		CSV.foreach("public/#{file}") do |row|
			if (!row.nil? || row != "") then
				good = Citilink.new
				good.supplier_no = row.last
				good.save!
			end
		end
	end
end

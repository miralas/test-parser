require 'open-uri'
require 'nokogiri'

namespace :parse do
	desc "Parse info"
	task :citilink => :environment do
		ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['development'])
		articles = Citilink.all
		articles.each do |article|
			page = Nokogiri::HTML(open("http://www.citilink.ru/search/?text=#{article.supplier_no}"))
			if !page.css('table.item').nil? then
				puts article.supplier_no
				article.name = page.css('table.item a')[1].text
				article.price = page.css('div.price')[0].text.sub!(" руб.\u20BD", "")
				category = page.css('table.item a')[0]['href']
				article.category_adress = trim_category(category, article.supplier_no)
				article.save
			end
		end
	end

	def trim_category(category, supplier_no)
		category.sub!("/catalog/", "") if category.include?("/catalog/")
		category.sub!("/#{supplier_no}/", "") if category.include?("/#{supplier_no}/")

		return category
	end
end
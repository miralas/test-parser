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
				category = page.css('table.item a')[0]['href'].sub!("/catalog/", "")
				article.category_adress = category.sub!("/#{article.supplier_no}/", "")
				article.save
			end
		end
	end
end
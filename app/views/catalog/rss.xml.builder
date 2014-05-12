xml.instruct!

xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
	xml.channel do
		xml.title @page_title
		xml.link(url_for(:action => "index", :only_path => false))
		xml.language "es-es"
		xml.ttl "40"
		xml.description "BlackHole - High quality Sunglasses"

		for glass in @glasses
			xml.item do
				xml.title(glass.name)
				xml.description("#{glass.name} by #{glass.manufacturer}")
				xml.pubDate(glass.created_at.to_s(:long))
				xml.guid(url_for(:action => "show", :id => glass, :only_path => false))
				xml.link(url_for(:action => "show", :id => glass, :only_path => false))
			end
		end
	end
end

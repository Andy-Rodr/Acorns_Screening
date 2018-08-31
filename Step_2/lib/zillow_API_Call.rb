require 'faraday'
require 'nokogiri'

class ZillowAPICaller
	def initialize()
		@res_address = ""
		@res_zip = ""
		@res_status = ""
	end

	def getSearchResults(req_addr, req_zip)
		conn = Faraday.new(:url => 'http://www.zillow.com/webservice/GetSearchResults.htm') do |faraday|
			faraday.request :url_encoded
			faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		end

		res = conn.get do |req|                           
		  	req.params['zws-id'] = 'X1-ZWz1gm79k3tibv_6y17p'
		  	req.params['address'] = req_addr
		  	req.params['citystatezip'] = req_zip
		end

		# puts res.status
		# puts res.success?
		# puts res.body

		@doc = Nokogiri::XML(res.body)
		res_add = @doc.xpath("//address/street").text
		res_zip = @doc.xpath("//address/zipcode").text

		@res_address = res_add
		@res_zip = res_zip
		@res_status = res.status
	end

	def res_address
		@res_address
	end

	def res_zip
		@res_zip
	end

	def res_status
		@res_status
	end

end
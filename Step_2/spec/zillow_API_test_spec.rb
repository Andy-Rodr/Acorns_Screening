require 'zillow_API_Call'

describe ZillowAPICaller do
	describe ".getSearchResults" do
		context 'When searching for a particular property' do
			it "sends back a response that matches the search criteria with a 200 status" do
				
				request_address = "21 Flora Spgs"
				request_zip = "92602"

				zac = ZillowAPICaller.new
				zac.getSearchResults(request_address, request_zip)

				expect(zac.res_address).to eq(request_address)
				expect(zac.res_zip).to eq(request_zip)

			end
		end
	end
end
require 'spec_helper'

describe Weather do

	describe "#new" do
		it "creates an instance of Weather" do
			expect( Weather.new() ).to be_an_instance_of Weather
		end
		it "sets location" do
			expect(Weather.new.location).to eq "Victoria, BC"
		end
		it "sets type" do
			expect(Weather.new.type).to eq "current"
		end
	end

	describe "#get" do
		context "location not found" do
			it "returns 404" do
				VCR.use_cassette("current/not_found") do
					response = Weather.new("This is not a city", 'current').get
					expect(response['cod']).to eq '404'
				end	
			end
		end
		context "current" do
			it "returns 200" do
				VCR.use_cassette("current/victoria") do
					response = Weather.new("Victoria, BC", 'current').get
					expect(response['cod']).to eq 200
				end
			end
		end
		context "forecast" do
			it "returns 200" do
				VCR.use_cassette("forecase/victoria") do
					response = Weather.new("Victoria, BC", 'forecast').get
					expect(response['cod']).to eq '200'
				end
			end
		end
	end
end


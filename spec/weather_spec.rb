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
		end
		context "location found" do
			context "current" do
			end
			context "forecast" do
			end
		end
	end
end


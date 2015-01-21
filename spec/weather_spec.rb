require 'spec_helper'

describe Weather do

	describe "#new" do
		it "creates an instance of Weather" do
			expect( Weather.new ).to be_an_instance_of Weather
		end
		context "When city is blank" do

			subject { Weather.new }

			it "sets city to 'Victoria, BC'" do
				expect(subject.city).to eq "Victoria, BC"
			end
		end
		context "When city is present" do
			
			subject { Weather.new "New York, New York" }
			
			it "sets the city" do
				expect( subject.city ).to eq "New York, New York"
			end
		end
	end
end


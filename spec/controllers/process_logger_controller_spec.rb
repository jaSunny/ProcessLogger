require 'rails_helper'

RSpec.describe ProcessLoggerController, :type => :controller do

	background do
		# currently not needed anymore..
	end

	before(:each) do
		load Rails.root + "spec/support/seeds.rb"
	end

	it "creates a new process" do
		json_payload = '{"title": "TestProcess", "amount_of_jobs":40}'
		put 'process/' , json_payload, { format: 'json' }
		expect(response.body).to include("TestProcess")
		expect(response.body).to include("40")
	end
		 
end
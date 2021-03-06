require 'rails_helper'

RSpec.describe "test", :type => :request do

	#background do
		# currently not needed anymore..
	#end

	before(:each) do
		load Rails.root + "spec/support/seeds.rb"
	end


	#
	#
	it "retrieving process details" do
		get 'process/1'
		expect(response.status).to eq(200)
		expect(response.body).to include("Process1")
		expect(response.body).to include("20")
	end

	#
	#
	it "retrieving process details with non existing id" do
		get 'process/99999'
		expect(response.status).to eq(404)
	end

	#
	#
	it "finishing an job successfully" do
		post 'process/4/job/success'
		expect(response.status).to eq(200)
		get 'process/4'
		expect(response.status).to eq(200)
		expect(response.body).to include("TestProcess")
		expect(response.body).to include("\"count_success\":1")
	end

	#
	#
	it "finishing an job successfully with non existing id" do
		post 'process/2000/job/success'
		expect(response.status).to eq(404)
	end

	#
	#
	it "finishing an job faulty" do
		post 'process/4/job/fail'
		expect(response.status).to eq(200)
		get 'process/4'
		expect(response.status).to eq(200)
		expect(response.body).to include("TestProcess")
		expect(response.body).to include("\"count_fail\":1")
	end

	#
	#
	it "finishing an job faulty with non existing id" do
		post 'process/200/job/fail'
		expect(response.status).to eq(404)
	end

	#
	#
	it "finishing an job faulty with terminated process id" do
		post 'process/5/job/fail'
		expect(response.status).to eq(410)
	end

	#
	#
	it "finishing an job faulty with terminated process id" do
		post 'process/5/job/success'
		expect(response.status).to eq(410)
	end	

	#
	#
	it "creates a new process" do
		#json_payload = "{'title': 'TestProcess', 'amount_of_jobs':40}"
		#json = { :format => 'json', :application => { :title => "foo", :description => "bar" } }
		#@request.env['RAW_POST_DATA'] = json_payload
		#put 'process/' 
		#json_payload = '{"title":"test","amount_of_jobs": 33}'
		#put 'process/', json_payload, {format: 'json', title: "larry", amount_of_jobs: 40 }
		#put 'process/', '{"title":"TestProcess","amount_of_jobs":40}'
		#expect(response.body).to include("TestProcess")
		#expect(response.body).to include("40")
	end 
end

require 'json'
class JobLoggerController < ApplicationController

	#
	#
	def start	
		@Process = ProcessLogger.new

		if(request.body.read.present?)
			 content = JSON.parse request.body.read
		else
			 render nothing: true, status: 400 and return
		end

		@Process.amount_of_jobs = content['amount_of_jobs']
		@Process.title = content['title']	
		@Process.save
		
		result = Hash.new
		result['data'] = ProcessLogger.last

		links = Hash.new
		links['terminate'] = "http://" + request.host + "process/:id"
		links['status'] = "http://" + request.host + "/process/:id/status"
		links['job_success'] = "http://" + request.host + "/process/:id/job/success"
		links['job_fail'] = "http://" + request.host + "/process/:id/job/fail"
		
		result['links'] = links
		puts "Background job started"
		render text: result.to_json
	end

	#
	#
	def terminate
		@Process = ProcessLogger.find_by_id(params[:id])
		if(@Process == nil)
			render nothing: true, status: 404 and return #Ressource Not Found
		end
		@Process.terminate = true
		@Process.save
		puts "Background job finished"
		render nothing: true, status: 200
	end

	#
	#
	def status
		@Process = ProcessLogger.find_by_id(params[:id])
		if(@Process == nil)
			render nothing: true, status: 404 and return #Ressource Not Found
		end		
		render text: @Process.to_json
	end

	#
	#
	def success		
		@Process = ProcessLogger.find_by_id(params[:id])

		if(@Process == nil)
			render nothing: true, status: 404 and return #Ressource Not Found
		end

		if(@Process.terminate == true)
			render nothing: true, status: 410 and return #Gone -> the resource is no longer available
		end

		#@Process.created_at = DateTime.now.yesterday.utc 
		if((((@Process.created_at - DateTime.now.utc).to_i).abs/3600) < 6) # if 6 hours past by
			@Process.count_success += 1
			@Process.save
			render nothing: true, status: 200
		else
			if(@Process.amount_of_jobs / 2 > @Process.count_success)
				puts "-----------------------------------------"
				puts "FATAL ERROR: less than 50% of the jobs was executed within 6 hours"
				puts "-----------------------------------------"
				render nothing: true, status: 410 #Gone -> the resource is no longer available
			else
				render nothing: true, status: 410 #Gone -> the resource is no longer available
			end
		end
	end

	#
	#
	def fail
		@Process = ProcessLogger.find_by_id(params[:id])

		if(@Process == nil)
			render nothing: true, status: 404 and return #Ressource Not Found
		end
		if(@Process.terminate == true)
			render nothing: true, status: 410 and return #Gone -> the resource is no longer available
		end

 		@Process.count_fail += 1
		@Process.save
		render nothing: true,  status: 200
	end
end

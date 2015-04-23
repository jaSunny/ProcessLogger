class AddingMoreDefaults < ActiveRecord::Migration
  def change
	remove_column :process_loggers, :amount_of_jobs
	add_column :process_loggers, :amount_of_jobs, :integer, :default => 0
  end
end

class AddingDefault2 < ActiveRecord::Migration
  def change
	remove_column :process_loggers, :count_success
	remove_column :process_loggers, :count_fail
	remove_column :process_loggers, :terminate
	add_column :process_loggers, :count_success, :integer, :default => 0
	add_column :process_loggers, :count_fail, :integer, :default => 0
	add_column :process_loggers, :terminate, :boolean, :default => false
  end
end

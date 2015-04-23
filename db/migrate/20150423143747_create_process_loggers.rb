class CreateProcessLoggers < ActiveRecord::Migration
  def change
    create_table :process_loggers do |t|
      t.string :title
      t.integer :amount_of_jobs
      t.integer :count_success
      t.integer :count_fail
      t.boolean :terminate

      t.timestamps
    end
  end
end

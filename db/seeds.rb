# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

ProcessLogger.create(title: 'Process1', count_success: 20, count_fail: 2, terminate: false, amount_of_jobs: 22)
ProcessLogger.create(title: 'Process_terminated', count_success: 10, count_fail: 2, terminate: true, amount_of_jobs: 12)
ProcessLogger.create(title: 'Process_bad', count_success: 1, count_fail: 20, terminate: true, amount_of_jobs: 22)




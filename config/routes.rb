Rails.application.routes.draw do

  ########
  # PUTs
  #
  put 'process/' => 'job_logger#start'

  ########
  # POSTs
  #
  post 'process/:id/job/success' => 'job_logger#success'
  post 'process/:id/job/fail' => 'job_logger#fail'

  ########
  # GETs
  #
  get 'process/:id' => 'job_logger#status'

  ########
  # POSTs
  #
  delete 'process/:id' => 'job_logger#terminate'

end

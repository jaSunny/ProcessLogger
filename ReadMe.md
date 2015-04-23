[![Build Status](https://travis-ci.org/jaSunny/ProcessLogger.svg?branch=master)](https://travis-ci.org/jaSunny/ProcessLogger)
[![Coverage Status](https://coveralls.io/repos/jaSunny/ProcessLogger/badge.svg?branch=master)](https://coveralls.io/r/jaSunny/ProcessLogger?branch=master)


# ProcessLogger
![Travis Test Success](https://github.com/jaSunny/ProcessLogger/blob/master/spec/travis.png)


## REST
creating new resources (process)
```
PUT http://ip:port/process
```
containing the following sample information as JSON
```json
{
  "title":"Process1",
  "amount_of_jobs":20
}
```
and we receiving as response the ressource details
```json
{
  "data":
      {
        "id":1,
        "title":"Process1",
        "created_at":"2015-04-23T16:46:34.264Z",
        "updated_at":"2015-04-23T16:46:34.264Z",
        "count_success":0,
        "count_fail":0,
        "terminate":false,
        "amount_of_jobs":20
      },
"links":
      {
        "terminate":"http://localhost/process/:id",
        "status":"http://localhost/process/:id/status",
        "job_success":"http://localhost/process/:id/job/success",
        "job_fail":"http://localhost/process/:id/job/fail"
      }
}
```
retrieving details for an existing resource (process)
```
GET http://ip:port/process/:id
```
containing the following sample information as JSON
```json
{
  "id":1,
  "title":"Process1",
  "created_at":"2015-04-23T16:46:34.264Z",
  "updated_at":"2015-04-23T16:46:34.264Z",
  "count_success":0,
  "count_fail":0,
  "terminate":false,
  "amount_of_jobs":20
}
```
now we can report if a job (e.g. cronjob) was successfull or faulty
```
POST http://ip:port/process/:id/job/{success|fail}
```
After 6 hours, the reporting will be closing and throw an error if more than 50% of the jobs were not successful



require 'aws-sdk-v1'
require 'aws-sdk'

Aws.config.update({
  region: 'us-west-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
})

s3 = Aws::S3::Client.new
resp = s3.list_buckets
S3_BUCKET = resp.buckets[0]

S3 = Aws::S3::Resource.new(region: 'us-west-1')

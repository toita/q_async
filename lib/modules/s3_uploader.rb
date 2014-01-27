#!/usr/local/bin/ruby
# -*- co#ding: utf-8 -*-

module S3
    AWS_CONF_PATH = File.expand_path('../../../config/aws.yml',  __FILE__)
    def uploader(filename)
        require 'aws-sdk'
        aws_conf = YAML.load_file(AWS_CONF_PATH)
        AWS.config(
            :access_key_id => aws_conf["s3"]["access_key_id"],
            :secret_access_key => aws_conf["s3"]["secret_access_key"])
        s3 = AWS::S3.new
        bucket_name = aws_conf["s3"]["bucket_name"]
        bucket = s3.buckets[bucket_name]

        begin
            basename = File.basename(filename)
            o = bucket.objects[basename]
            o.write(:file => filename, :acl => "public_read")
            return true
        rescue
            return false
        end
    end
    module_function :uploader
end

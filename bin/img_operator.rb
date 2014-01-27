#!/usr/local/bin/ruby
# -*- co#ding: utf-8 -*-

$LOAD_PATH.push(File.dirname(__FILE__))
require "task_operator"
require "img_resizer"
require "s3_uploader"


class ImgOperator < TaskOperator

    @@TASK_TYPE = "IMG_TASK"
    AWS_CONF_PATH = File.expand_path('../../config/aws.yml',  __FILE__)
    include Img
    include S3

    def initialize()
        aws_conf = YAML.load_file(AWS_CONF_PATH)
        @@WORKING_DIR = aws_conf['local']['working_dir']
    end

    ## 対象のimgファイルをセットする
    def set_task(img_path)
        if File.exist?(img_path)
            enqueue(img_path)
        end
    end

    ## キューからファイルを取り出して、リサイズ＆s3に送る
    def run_task()
        img_path = dequeue()
        p img_path
        if File.exist?(img_path)
            size = {"width" => 150, "height" => 150}
            dest_path = @@WORKING_DIR + '/' + img_path.split("/")[-1] + ".tmp"
            p dest_path
            resize(img_path, size, dest_path)

            uploader(dest_path)
        end
    end

end


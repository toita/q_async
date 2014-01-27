#!/usr/local/bin/ruby
# -*- co#ding: utf-8 -*-

TEST_ROOT_DIR = File.expand_path('../../../bin',  __FILE__)
$LOAD_PATH.push(TEST_ROOT_DIR)
require "img_operator"

io = ImgOperator.new
p io.init()
io.set_task("/home/toita/q_async_w/tmp/img/can1.jpg")
io.run_task()

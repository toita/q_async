#!/usr/local/bin/ruby
# -*- co#ding: utf-8 -*-

ROOT_DIR = File.expand_path('../../',  __FILE__)
$LOAD_PATH.push(ROOT_DIR + "/lib")
$LOAD_PATH.push(ROOT_DIR + "/lib/modules")

require "q_manager"

class TaskOperator

    @@TASK_TYPE = "TASK"

    ## 前処理、戻り値見たいから、コンストラクタ使わない。
    def init()
        @q = QManager.new
        if @q.connect == nil
            p "connection error"
            exit
        end
        @q.set_key(@@TASK_TYPE)
    end

    def enqueue(member)
        @q.add_member(member)
    end

    def dequeue()
        member = @q.get_member()
        return member
    end

end

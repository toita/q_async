require "redis"
require "yaml"

REDIS_CONF_PATH = File.expand_path('../../config/redis.yml',  __FILE__)

class QManager

    def initialize()
        redis_conf = YAML.load_file(REDIS_CONF_PATH)
        if !ENV['q_async_env']
            @redis_host = redis_conf['development']['host']
            @redis_port = redis_conf['development']['port']
        end
    end


    ### コネクト
    # 戻り値 : 成功 => 整数、 失敗 => nil
    # Redis.newしただけだと、コネクトが成功してるかわからないのでサイズを取得する
    def connect(host=@redis_host, port=@redis_port)
        begin
            @redis = Redis.new(:host => host, :port => port)
            return @redis.DBSIZE()
        rescue => exception
            puts "error, #{exception.message}"
            return nil
        end
    end


    ### タスクのタイプをセット
    def set_key(task_type)
        @task_type = task_type
    end


    ### タスクの追加
    # point(優先度、5がMAX, 1がMIN, デフォルトが3)
    # 戻り値 : 成功 => true, 登録済み => false, 失敗 => nil
    def add_member(member, point=3)
        if point < 1 or point > 5
            retrun nil
        end
        begin
            return @redis.zadd(@task_type, point, member)
        rescue => exception
            puts "error, #{exception.message}"
            return nil
        end
    end


    ### 一番目のタスクを取り出す
    # 戻り値 : String, 失敗orタスクが空ならnil
    def get_member()
        begin
            res = @redis.zrange(@task_type, 0, 0)
        rescue => exception
            puts "error, #{exception.message}"
            return nil
        end

        if res.size == 1
            if del_task(res[0]) != nil
                return res[0]
            end
        end
        # 取り出しはうまくいったが、削除は失敗した場合
        return nil
    end


    ### タスクの削除
    # 戻り値 : 失敗したらnil
    def del_task(member)
        begin
            return @redis.zrem(@task_type, member)
        rescue => exception
            puts "error, #{exception.message}"
            return nil
        end
    end

end

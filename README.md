# q_async

## セットアップ

### 構成
```bash
$ tree
.
├── Gemfile
├── README.md
├── bin
│   ├── img_operator.rb
│   └── task_operator.rb
├── config
│   ├── aws.yml
│   └── redis.yml
├── lib
│   ├── modules
│   │   ├── img_resizer.rb
│   │   └── s3_uploader.rb
│   └── q_manager.rb
├── log
├── test
│   └── bin
│       └── img_operator_test.rb
└── tmp
    └── img
```

### Packageインストール
```bash
$ sudo apt-get install redis-server redis-doc
$ sudo apt-get install imagemagick
```

### Ruby関連のPackageインストール
```bash
$ git clone git@github.com:toita/q_async.git
$ cd q_async
$ bundle install
```

### S3のID、キー、バケット名をセット
config/aws.ymlを編集

---

## 動かす
ファイルをリサイズして、s3にアップロードする
```bash
$ ruby test/bin/img_operator_test.rb
```

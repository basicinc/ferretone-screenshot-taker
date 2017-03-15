# ferretone-screenshot-taker
スクリーンショットを取るLambdaコード

## ENV
```bash
export LD_LIBRARY_PATH=/tmp/fontconfig/lib/

export BUCKET_NAME=homeup-dev
export FOLDER=screenshot
export PREFIX=ss_
```

## Request
```
{"url": "http://google.co.jp"}
```

## Response
```
"screenshot/ss_1489557470600.jpeg"
```

## Build
```bash
chmod u+x pack.sh; ./pack.sh
```
screenshot.zipファイルをlambdaへアップロードする。

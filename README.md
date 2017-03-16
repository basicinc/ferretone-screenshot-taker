# ferretone-screenshot-taker
スクリーンショットを取るLambdaコード

## ENV
```bash
export LD_LIBRARY_PATH=/tmp/fontconfig/lib/
```

## Request
```
{"url": "http://google.co.jp", "bucket": "homeup-dev", "key": "screenshot/site/abc12345/ss_123.jpeg"}
```

## Response
```
Done!
```

## Deploy to lambda
We need precompile phantomjs and fontconfig then zip it and upload to lambda together with js file

* Run command below to create lambda deployment package

```bash
chmod u+x pack.sh; ./pack.sh
```
* In lambda management page, chose Code entry type to `Upload a .ZIP file` then upload screenshot.zip to lambda.
* Remember to set Environment variables for `LD_LIBRARY_PATH`

## Referent
http://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/api-gateway-create-api-from-example.html

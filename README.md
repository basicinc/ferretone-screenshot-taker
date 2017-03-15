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

## Deploy to lambda
We need precompile phantomjs and fontconfig then zip it and upload to lambda together with js file

* Run command below to create lambda deployment package

```bash
chmod u+x pack.sh; ./pack.sh
```
* In lambda management page, chose Code entry type to `Upload a .ZIP file` then upload screenshot.zip to lambda.
* Remember to set Environment variables for `LD_LIBRARY_PATH`

var childProcess = require('child_process');
var path = require('path');
var AWS = require('aws-sdk');

/********** CONFIGS **********/

var BUCKET_NAME = process.env.BUCKET_NAME || 'homeup-dev';
// var FOLDER = process.env.FOLDER || 'screenshot';
// var FILENAME_BASE = process.env.PREFIX || 'ss_';
var PHANTOM_BINARY = 'phantomjs';

/********** HELPERS **********/

// var filepath = function(base, folder) {
//   var today = new Date();
//   var filename = base + today.getTime() + ".jpeg";
//   return FOLDER + "/" + folder + "/" + filename;
// }

var save_to_s3 = function(payload, bucket, path, context) {
  var s3 = new AWS.S3();
  var param = {
    Bucket: bucket,
    Key: path,
    ContentType: 'image/jpeg',
    Body: payload
  };
  s3.upload(param, function(err, data) {
    if (err) {
      context.fail(err);
    } else {
      context.succeed("Done!");
    }
  });
};

/********** MAIN **********/

exports.handler = function(event, context) {
  process.env['PATH'] = process.env['PATH'] + ':' + process.env['LAMBDA_TASK_ROOT'];
  var message = JSON.parse(event.Records[0].Sns.Message);
  var phantomPath = path.join(__dirname, PHANTOM_BINARY);
  var processArgs = [
    "--ssl-protocol=any",
    path.join(__dirname, 'phantom-script.js'),
    message.url
  ];
  var retry = message.retry || 0;

  if (!message.url || !message.key || !message.bucket) {
    context.fail("Url and key must be provided.");
    return;
  }

  childProcess.exec('mv fontconfig /tmp/fontconfig; /tmp/fontconfig/usr/bin/fc-cache -fs', function(error) {
    childProcess.execFile(phantomPath, processArgs, {maxBuffer: 1024 * 5000}, function(error, stdout, stderr) {
      if (error) {
        context.fail(error);
        return;
      }
      if (stderr) {
        context.fail(error);
        return;
      }

      var buffer = new Buffer(stdout, 'base64');
      save_to_s3(buffer, message.bucket, message.key, context);
    });
  });
}

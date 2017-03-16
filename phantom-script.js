var system = require('system');

var page = require('webpage').create();
page.settings.userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36';

// Passed in from parent process
var url = system.args[1];
var ratio = system.args[2].split(/[:\/]/).reduce(function(width, height){return parseInt(width)/parseInt(height)});

page.viewportSize = {
  width: 1280,
  height: 720
};

page.open(url, function start(status) {
  window.setTimeout(function() {
    if (ratio && ratio > 0) {
      page.clipRect = {
        top:    0,
        left:   0,
        width:  page.viewportSize.width,
        height: page.viewportSize.width/ratio
      };
    }

    var base64 = page.renderBase64('JPEG');
    system.stdout.write(base64);
    phantom.exit();

  }, 1000);
});

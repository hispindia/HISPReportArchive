const phantom = require('phantom');
const CronJob = require('cron').CronJob;
var parser = require('cron-parser');
function phantomReport(param,callback) {


    phantom.create().then(function (ph) {
        ph.createPage().then(function (page) {

            var flag = 0;
		page.property('onConsoleMessage',function(msg, lineNum, sourceId) {
		  console.log('CONSOLE: ' + msg + ' (from line #' + lineNum + ' in "' + sourceId + '")');
		});

page.property('onError', function (msg, trace) {
    console.log(msg);
    trace.forEach(function(item) {
        console.log('  ', item.file, ':', item.line);
    })
})

for (var setting in page.settings) {
    console.log(setting + ": " + page.settings[setting]);
}

try {
    var job = new CronJob('00 23 * * *', function() {
  
            page.property('onNavigationRequested', function (url, type, willNavigate, main) {
                console.log('= onNavigationRequested');
                console.log('  destination_url: ' + url);
                console.log('  type (cause): ' + type);
                console.log('  will navigate: ' + willNavigate);
                console.log('  from page\'s main frame: ' + main);
            });

            page.property('onResourceReceived', function (response) {
                console.log('= onResourceReceived()');
                console.log('  id: ' + response.id + ', stage: "' + response.stage + '", response: ' + JSON.stringify(response));
            });


            page.property('onResourceRequested', function (request) {
                console.log('= onResourceRequested()');
                console.log('  request: ' + JSON.stringify(request, undefined, 4));
            });

            page.open(param.BASE_URL + param.REPORT_URL).then(function (status) {
                console.log(status);
                try {
                    page.evaluate(function () {
                        setTimeout(function () {

                            document.getElementById("j_username").value = "priyanka";
                            document.getElementById("j_password").value = "Tibet@123";
                            document.getElementById("submit").click();
                        }, 100)                                 
                    })
                    
                    
                } catch (ex) {
                    var fullMessage = "\nJAVASCRIPT EXCEPTION";
                    fullMessage += "\nMESSAGE: " + ex.toString();
                    for (var p in ex) {
                        fullMessage += "\n" + p.toUpperCase() + ": " + ex[p];
                    }
                    console.log(fullMessage);
                }
            });

            page.property('onLoadFinished', function() {
                console.log('==== onLoadFinished()');
                try{
                   
                
            }catch(ex){
                
                   var fullMessage = "\nJAVASCRIPT EXCEPTION";
                   fullMessage += "\nMESSAGE: " + ex.toString();
                   for (var p in ex) {
                       fullMessage += "\n" + p.toUpperCase() + ": " + ex[p];
                   }
                   console.log(fullMessage);
               }
            })

                }, function () {
                    phantom.exit;
                    /* This function is executed when the job stops */
                },
                true/* Start the job right now */
                /* Time zone of this job. */
				);
                
            } catch (ex) {
                var fullMessage = "\nJAVASCRIPT EXCEPTION";
                fullMessage += "\nMESSAGE: " + ex.toString();
                for (var p in ex) {
                    fullMessage += "\n" + p.toUpperCase() + ": " + ex[p];
                                 }
                console.log(fullMessage);
            }            
            
        });
        
        
    });
}

const BASE_URL = "http://139.162.16.101/tibet_pro";
    const REPORT_URL = "/dhis-web-reporting/generateHtmlReport.action?uid=ahFo0nbqWEQ&";
    const DEST_PATH_BASE = "";


    setTimeout(function () {
        new phantomReport({
            BASE_URL: BASE_URL,
            REPORT_URL: REPORT_URL
        }, function (response) {
            console.log("test")
        })
    }, 100);

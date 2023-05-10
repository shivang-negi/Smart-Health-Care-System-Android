const http = require('http');
const https = require('https');
const { execSync  } = require('child_process');
const { exec  } = require('child_process');
const fs = require('fs');
const url = require('url');

const PORT = 8000;

const server = http.createServer(async (req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'}); 
 
  const urlParts = url.parse(req.url, true);
  const type = urlParts.query.type;
  if(type=="1") { 
    const file = urlParts.query.filename;
    const imageUrl = urlParts.query.image;

    const localPath = 'C:\\Users\\ACER\\Downloads\\RESEARCH PAPER CODE FINAL YEAR PROJECT-20230405T140232Z-001\\RESEARCH PAPER CODE FINAL YEAR PROJECT\\'+file+'.jpg';

    const stream = fs.createWriteStream(localPath);
    var flag = false;

    https.get(imageUrl, (response) => {
      response.pipe(stream);

      stream.on('finish', () => {
        stream.close(() => {
          console.log('Image downloaded successfully.');
          execSync(`matlab -nodisplay -nosplash -nodesktop -wait -r \"testing_network(\'${file}.jpg\',\'${file}.txt\');exit;\"`,
          { cwd: 'C:\\Users\\ACER\\Downloads\\RESEARCH PAPER CODE FINAL YEAR PROJECT-20230405T140232Z-001\\RESEARCH PAPER CODE FINAL YEAR PROJECT\\' }, 
          (err, stdout, stderr) => {
            if (err) {
              res.end("Error fetching data!");
              return;
            }
          });

          try {
            const msg = fs.readFileSync(`C:\\Users\\ACER\\Downloads\\RESEARCH PAPER CODE FINAL YEAR PROJECT-20230405T140232Z-001\\RESEARCH PAPER CODE FINAL YEAR PROJECT\\${file}.txt`, 'utf8');
            var arr = msg.split(/\r?\n/);
            const data = "Prediction: " + arr[0] + "\nProbability: " + arr[1];
            res.end(data);
          } catch (err) {
            res.end("Error showing result!");
          }
        });
      });
    }).on('error', (err) => {
      fs.unlink(localPath, () => {
        flag = true;
      });
    });

    if(flag) {
      res.end("Error downloading image!");
      return;
    }
  }

  if(type=="2") {
    const str = urlParts.query.input;
    var command = `python -W ignore predict.py ${str}`;
    console.log(command);
    exec(command,
      { cwd: 'C:\\Users\\ACER\\Downloads\\symptoms to disease\\' }, 
      (err, stdout, stderr) => {
        if (err) {
          res.end("Error fetching data!");
          return;
        }
        var out = stdout.substring(2,stdout.length - 4);
        res.end(out); 
      });
  }

  if(type=="3") {
    const file = urlParts.query.filename;
    const file_url = urlParts.query.pdf_file;

    const localPath = 'C:\\Users\\ACER\\Downloads\\report to advice\\'+file+'.pdf';

    const stream = fs.createWriteStream(localPath);
    var flag = false;

    https.get(file_url, (response) => {
      response.pipe(stream);

      stream.on('finish', () => {
        stream.close(() => {
          console.log('PDF downloaded successfully.');
          
          var str = file+'.pdf';
          var command = `python -W ignore extract_words_from_PDF.py ${str}`;
          console.log(command);
          exec(command,
            { cwd: 'C:\\Users\\ACER\\Downloads\\report to advice\\' }, 
            (err, stdout, stderr) => {
              if (err) {
                res.end("Error fetching data!");
                return;
              }
              res.end(stdout); 
            });


        });
      });
    }).on('error', (err) => {
      fs.unlink(localPath, () => {
        flag = true;
      });
    });

    if(flag) {
      res.end("Error downloading pfd!");
      return;
    }
  }
});

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

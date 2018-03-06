// index.js
const http = require('http');
const os   = require('os');
const port = process.env.NODE_PORT;

const requestHandler = (request, response) => {
  console.log(request.url);
  response.end(`Hello Node.js Server!\n\nProcessed by ${os.hostname()}`);
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err);
  }

  console.log(`server is listening on ${port}`);
})
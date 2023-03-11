const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

const messages = [];

app.get('/', (req,res)=>{
    res.send("<h1>Hello</h1>");
});

io.on('connection', (socket) => {
  const username = socket.handshake.query.username;
  socket.on('messageText',(data)=>{
    const message = {message: data.message,sender: username}
    messages.push(message);
    console.log(message);
   io.emit('messageText',message);
  });
  socket.on('messageImage',(data)=>{
      const message = {message: data.message ,sender: username};
      messages.push(data);
//      console.log(message);
      io.emit('messageImage',message);
    });
});

server.listen(3000, () => {
  console.log('listening on *:3000');
});
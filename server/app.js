const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const { MongoClient } = require('mongodb');
const { log } = require('console');

const io = new Server(server);
const url = 'mongodb://localhost:27017';
const client = new MongoClient(url);
const dbName = 'userdata';

async function connect() {
  await client.connect();
}

connect();
const db = client.db(dbName);

async function insertData(collection_name,data) {
  const collection = db.collection(collection_name);
  const insertResult = await collection.insertOne(data);
  console.log('Inserted documents =>', insertResult);
}

async function deleteData(collection_name) {
  const collection = db.collection(collection_name);
  const deleteResult = await collection.deleteMany({});
  console.log('Deleted documents =>', deleteResult);
}

async function getData(collection_name) {
  const collection = db.collection(collection_name);
  const findResult = await collection.find({}).toArray();
  return findResult;
}

async function check() {
  var result = await getData('9718151303_9557641937');
  console.log(result);
}
check();

app.get('/', (req,res)=>{
    res.send("<h1>This is my Server</h1>");
});

io.sockets.on('connection',function (socket) {
  socket.on('join',async function(data) {

    console.log('======Joined Room======');
    console.log(data);

    socket.join(data.room);
    var str = data.user + "_" + data.receiver;
    var res = await getData(str);
    console.log(res);
    socket.emit('oldmsgs',res);
    deleteData(str);
  });

  socket.on('message', function(data) {
    console.log('======Text Message======');
    console.log(data);

    const clients = io.sockets.adapter.rooms.get(data.room);
    const numClients = clients.size;
    console.log(numClients);

    if(numClients == 1) {
      var str = data.receiver + "_" + data.sender;
      var valueToInsert = {'msg':data.msg,'sender':data.sender,'receiver':data.receiver,'type':'text'};
      console.log(valueToInsert);
      insertData(str,valueToInsert);
    }
    else {
      socket.broadcast.to(data.room).emit('new_msg', {
        msg: data.msg,
        sender: data.sender
      });
    }
  });

  socket.on('imageMessage', function (data) {
    console.log('======Image message======');
    console.log(data);
    
    const clients = io.sockets.adapter.rooms.get(data.room);
    const numClients = clients.size;
    console.log(numClients);

    if(numClients == 1) {
      var str = data.receiver + "_" + data.sender;
      var valueToInsert = {'url':data.url,'sender':data.sender,'receiver':data.receiver,'type':'image'};
      console.log(valueToInsert);
      insertData(str,valueToInsert);
    }
    else {
      socket.broadcast.to(data.room).emit('receiveImage',{
      url: data.url,
      sender: data.sender
      });
    }
  });

  socket.on('fileMessage', function(data) {
    console.log('======File message======');
    console.log(data);
    
    const clients = io.sockets.adapter.rooms.get(data.room);
    const numClients = clients.size;
    console.log(numClients);

    if(numClients == 1) {
      var str = data.receiver + "_" + data.sender;
      var valueToInsert = {'url':data.url,'sender':data.sender,'receiver':data.receiver,'type':'file','filename': data.filename};
      console.log(valueToInsert);
      insertData(str,valueToInsert);
    }
    else {
      socket.broadcast.to(data.room).emit('receiveFile',{
      url: data.url,
      sender: data.sender,
      filename: data.filename
      });
    }
  });

  socket.on('message_request',function (data) {
    console.log("===========Message Request============");
    console.log(data);

    insertData('pending_'+data.receiver,{
      sender: data.sender
    });
  });

  socket.on('check_messages',async function (data) {
    console.log('=========Check For Messages==========');
    console.log(data);

    var res = await getData('pending_'+data.user);
    if(res.length>0) {
      socket.emit('AddNewMessages',res);
      deleteData('pending_'+data.user);
    }
  });
});

io.sockets.on('disconnect', function() {
  io.sockets.disconnect();
  io.sockets.close();
});

server.listen(3000, () => {
  console.log('listening on *:3000');
});
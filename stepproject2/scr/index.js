const express = require('express');
const app = express();
const port = 80;

app.get('/', (req, res) => {
  res.send('Hello World!');
  //res.status(404).send('Hello World!');
});

var server = app.listen(port, () => {
  console.log('App listening');
});

module.exports = server;

const request = require('supertest');
//const server = require('../index.js');
//const app = request(server);

describe('GET /', () => {
  var server;
  beforeEach(function () {
    server = require('../index');
  });
  afterEach(function () {
    server.close();
  });
  it('responds to /', function testSlash(done) {
    request(server)
      .get('/')
      .expect(200, done);
  });
});


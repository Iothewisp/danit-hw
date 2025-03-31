const winston = require('winston');
const fluentLogger = require('fluent-logger');

const fluentTransport = fluentLogger.createFluentSender('js_app', {
  host: 'localhost',
  port: 24224,
  timeout: 3.0
});

const logger = winston.createLogger({
  level: 'info',
  transports: [new winston.transports.Console()]
});

logger.on('data', (log) => {
  fluentTransport.emit('winston', {
    level: log.level,
    message: log.message,
    meta: log.meta || {},
    timestamp: new Date().toISOString()
  });
});

module.exports = logger;

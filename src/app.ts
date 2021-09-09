import express from 'express';

// Controllers (route handlers)
import * as apiController from './controllers/api';

// Create Express server
const app = express();

// Express configuration
app.set('port', process.env.PORT || 8080);
app.use(express.json());
app.use(express.urlencoded({
  extended: true
}));

app.get('/', function (req, res) {
  res.send({
    hello: 'world',
  });
});

/**
 * API examples routes.
 */
app.get('/api/ping', apiController.ping);

export default app;

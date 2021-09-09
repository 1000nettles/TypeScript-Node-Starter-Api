import express from 'express';

// Controllers (route handlers)
import * as apiController from './controllers/api';

// Create Express server
const app = express();

// Express configuration
app.set('port', process.env.PORT || 3000);
app.use(express.json());
app.use(express.urlencoded({
  extended: true
}));

/**
 * API examples routes.
 */
app.get('/api/ping', apiController.ping);

export default app;

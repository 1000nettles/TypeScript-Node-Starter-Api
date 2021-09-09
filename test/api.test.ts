import request from 'supertest';
import app from '../src/app';

describe('GET /api/ping', () => {
    it('should return a pong response', (done) => {
        request(app).get('/api/ping')
            .expect(200, {
                ping: 'pong',
            }, done);
    });
});

'use strict';

import { Response, Request } from 'express';

/**
 * List of API examples.
 * @route GET /api/ping
 */
export const ping = (req: Request, res: Response) => {
    res.send({
        ping: 'pong',
    });
};

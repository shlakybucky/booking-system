import { Injectable, NestMiddleware } from "@nestjs/common";
import { Request, Response, NextFunction } from "express";
import { Counter, Histogram, collectDefaultMetrics, register } from "prom-client";

collectDefaultMetrics({
  prefix: 'nodejs_',
});

// Создаём метрики один раз вне класса
const httpRequestDurationInSeconds = new Histogram({
  name: 'http_request_duration_in_seconds',
  help: 'Duration of HTTP requests',
  labelNames: ['method', 'route', 'status'],
  buckets: [0.05, 0.1, 0.3, 0.5, 0.7, 1],
  registers: [register],
});

const httpRequestTotal = new Counter({
  name: 'http_request_total',
  help: 'Total amount of requests',
  labelNames: ['method', 'route', 'status'],
  registers: [register],
});

@Injectable()
export class MetricsMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction): void {
    const endTimer = httpRequestDurationInSeconds.startTimer();
    
    res.on('finish', () => {
      const route = (req.route && req.route.path) ||
        req.path ||
        req.originalUrl ||
        'unknown';
      
      const labels = {
        method: req.method,
        route,
        status: res.statusCode.toString(),
      };
      
      httpRequestTotal.inc(labels);
      endTimer(labels);
    });
    
    next();
  }
}

export { register };





// import { Injectable, NestMiddleware } from "@nestjs/common";
// import { Request, Response,  NextFunction} from "express";
// import { Counter, Histogram, collectDefaultMetrics, register } from "prom-client";

// collectDefaultMetrics({
//     prefix: 'nodejs_',
// });

// @Injectable()
// export class MetricsMiddleware implements NestMiddleware{
//     private readonly httpRequestDurationInSeconds = new Histogram({
//         name: 'http_request_duration_in_seconds',
//         help: 'Duration of HTTP requests',
//         labelNames: ['method', 'route', 'status'],
//         buckets: [0.05, 0.1, 0.3, 0.5,  0.7, 1],
//     });

//     private readonly httpRequestTotal = new Counter({
//         name: 'http_request_total',
//         help: 'Total amount of requests',
//         labelNames: ['method', 'route', 'status'], 
//     });

//     use(req: Request, res: Response, next: NextFunction): void {
//         const endTimer = this.httpRequestDurationInSeconds.startTimer();

//         res.on('finish', () => {
//             const route = (req.route && req.route.path) ||
//                             req.path ||
//                             req.originalUrl ||
//                             'unknown';
//             const labels = {
//                 method: req.method,
//                 route,
//                 status: res.statusCode.toString(),
//             };

//             this.httpRequestTotal.inc(labels);
//             endTimer(labels);
//         });

//         next();
//     }
// }

// export { register };
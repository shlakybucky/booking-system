import { Module, MiddlewareConsumer, RequestMethod } from '@nestjs/common';
import { MetricsController } from './metrics.controller';
import { MetricsMiddleware } from './metrics.middleware';

@Module({
    controllers: [MetricsController],
})
export class MetricsModule{
    configure(consumer: MiddlewareConsumer){
        consumer.apply(MetricsMiddleware)
                .forRoutes({ path: '*', method: RequestMethod.ALL});
    }
}
import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { EventsModule } from './events/events.module';
import { BookingModule } from './booking/booking.module';
import { PrismaModule } from './prisma/prisma.module';
import { MetricsModule } from './metrics/metrics.module';
import { MetricsMiddleware } from './metrics/metrics.middleware';

@Module({
  imports: [PrismaModule, EventsModule, BookingModule, MetricsModule],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(MetricsMiddleware)
      .forRoutes('*');
  }
}



// import { Module } from '@nestjs/common';
// import { EventsModule } from './events/events.module';
// import { BookingModule } from './booking/booking.module';
// import { PrismaModule } from './prisma/prisma.module';
// import { MetricsModule } from './metrics/metrics.module';

// @Module({
//   imports: [PrismaModule, EventsModule, BookingModule, MetricsModule],
// })
// export class AppModule {}

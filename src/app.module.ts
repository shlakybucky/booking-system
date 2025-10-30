import { Module } from '@nestjs/common';
import { EventsModule } from './events/events.module';
import { BookingModule } from './booking/booking.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [PrismaModule, EventsModule, BookingModule],
})
export class AppModule {}

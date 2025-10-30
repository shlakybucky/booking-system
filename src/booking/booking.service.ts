import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { ReservationResult } from './booking.types';
import { BookingEntity } from './entities/booking.entity';

@Injectable()
export class BookingService {
  constructor(private readonly prisma: PrismaService) {}

  async reserve(eventId: number, userId: number): Promise<ReservationResult> {
    return await this.prisma.$transaction(async (tx) => {
      const event = await tx.$queryRawUnsafe(
        `SELECT * FROM "events" WHERE id = $1 FOR UPDATE`,
        eventId,
      );

      if (!event) {
        return { success: false, message: 'Event not found' };
      }

      const exists = await tx.booking.findUnique({
        where: { event_user_unique: { eventId, userId } } as any, 
      }).catch(() => null);

      if (exists) {
        return { success: false, message: 'You already booked this event' };
      }

      const booking = await tx.booking.create({
        data: { eventId, userId },
      });

      return { success: true, booking: booking as BookingEntity };
    });
  }
}
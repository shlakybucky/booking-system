import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { ReservationResult } from './booking.types';
import { BookingEntity } from './entities/booking.entity';
import { errorMonitor } from 'events';

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

  async findMany(): Promise<any[]> {
  const bookings = await this.prisma.booking.findMany({
    include: {
      event: {
        select: {
          id: true,
          name: true,
          totalSeats: true,
        }
      },
    },
    orderBy: {
      createdAt: 'desc',
    },
  });

  // throw new Error();
  return bookings;
}

async findManyWithUsers(): Promise<any[]> {
  const bookings = await this.prisma.booking.findMany({
    include: {
      event: {
        select: {
          id: true,
          name: true,
          totalSeats: true,
          createdAt: true,
        }
      },
    },
    orderBy: {
      createdAt: 'desc',
    },
  });

  return bookings.map(booking => ({
    id: booking.id,
    eventId: booking.eventId,
    userId: booking.userId,
    createdAt: booking.createdAt,
    event: booking.event,
  }));
}
}
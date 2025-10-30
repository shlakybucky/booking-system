import { Booking } from '@prisma/client';


export class BookingEntity implements Booking{
  id!: number;
  eventId!: number;
  userId!: number;
  createdAt!: Date;
}

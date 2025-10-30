import { BookingEntity } from './entities/booking.entity';

export type ReservationResult =
  | { success: true; booking: BookingEntity }
  | { success: false; message: string };

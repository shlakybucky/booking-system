import { Event } from '@prisma/client';

export class EventEntity implements Event {
  id!: number;
  name!: string;
  totalSeats!: number;
  createdAt!: Date;
  updatedAt!: Date;
}
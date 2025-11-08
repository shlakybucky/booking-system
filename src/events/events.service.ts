// src/events/events.service.ts
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { EventEntity } from './entities/events.entities';
import { CreateEventDto, TopTenEventsDto } from './dto/event.dto';

@Injectable()
export class EventsService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll(): Promise<EventEntity[]> {
    const events = await this.prisma.event.findMany();
    return events.map(e => ({
      id: e.id,
      name: e.name,
      totalSeats: e.totalSeats,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    } as EventEntity));
}

  async findOne(id: number): Promise<EventEntity> {
    const event = await this.prisma.event.findUnique({ where: { id } });
    if (!event) {
      throw new NotFoundException(`Event with id ${id} not found`);
    }
    return event as EventEntity;
  }

  async create(dto: CreateEventDto): Promise<EventEntity> {
    const event = await this.prisma.event.create({
      data: {
        name: dto.name,
        totalSeats: dto.totalSeats,
      },
    });
    return event as EventEntity;
  }

  async delete(id: number): Promise<void> {
    const existing = await this.prisma.event.findUnique({ where: { id } });
    if (!existing) {
      throw new NotFoundException(`Event with id ${id} not found`);
    }
    await this.prisma.event.delete({ where: { id } });
  }

  async findTopTen (date: string): Promise<TopTenEventsDto[]>{

      if(!date) {
        throw new BadRequestException("Query parameter 'date' is required. Use '1day', '1month' or '1year'.");
      }

      const allowed = ['1day', '1month', '1year'];
      if(!allowed.includes(date)){
        throw new BadRequestException("Use '1day', '1month' or '1year'");
      }

      const timeNow = new Date();
      const startDate = new Date();

      switch(date){
        case '1day':
          startDate.setDate(timeNow.getDate() - 1);
          break;
        case '1month':
          startDate.setDate(timeNow.getMonth() - 1);
          break;
        case '1year':
          startDate.setDate(timeNow.getFullYear() - 1);
        break;
        default: 
          throw new Error("No such period");
      }

      const topBookings= await this.prisma.booking.groupBy({
        by: ['eventId'],
        where: {
          createdAt: {
            gte: startDate,
            lte: timeNow,
          },
        },
        _count: {
          eventId: true,
        },
        orderBy: {
          _count: {
            eventId: 'desc',
          },
        },
        take: 10,
      });

      if(topBookings.length === 0) return [];

      const orderedEventIds = topBookings.map(b => b.eventId);

      const events = await this.prisma.event.findMany({
        where: { id : { in: orderedEventIds }},
        include: {
          bookings: {
            select: {userId: true},
          },
        },
      });

      const eventMap = new Map<number, typeof events[0]>();
      for(const ev of events){
        eventMap.set(ev.id, ev);
      }

      const result: TopTenEventsDto[] = topBookings.map(top => {
        const ev = eventMap.get(top.eventId);
        const userIds = ev ? ev.bookings.map(b => b.userId) : [];
        const totalCount = top._count?.eventId?? 0;

        return {
          name: ev ? ev.name : "unknown event",
          userId: userIds,
          totalCount,
        };
      });
      return result;
  }
}
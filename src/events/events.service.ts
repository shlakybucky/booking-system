// src/events/events.service.ts
import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { EventEntity } from './entities/events.entities';
import { CreateEventDto } from './dto/event.dto';

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
}








// // src/events/events.service.ts
// import { Injectable, NotFoundException } from '@nestjs/common';
// import { PrismaService } from '../prisma/prisma.service';
// import { EventEntity } from './entities/events.entities';
// import { CreateEventDto, UpdateEventDto } from './dto/event.dto';

// @Injectable()
// export class EventsService {
//   constructor(private readonly prisma: PrismaService) {}

//   async findAll(): Promise<EventEntity[]> {
//     const events = await this.prisma.event.findMany();
//     return events as EventEntity[];
//   }

//   async findOne(id: number): Promise<EventEntity | null> {
//     const event = await this.prisma.event.findUnique({ where: { id } });
//     return event as EventEntity | null;
//   }

//   async create(dto: CreateEventDto): Promise<EventEntity> {
//     const event = await this.prisma.event.create({
//       data: dto,
//     });
//     return event as EventEntity;
//   }

//   async update(id: number, dto: UpdateEventDto): Promise<EventEntity> {
//     const event = await this.prisma.event.findUnique({ where: { id } });
//     if (!event) throw new NotFoundException(`Event ${id} not found`);

//     const updatedEvent = await this.prisma.event.update({
//       where: { id },
//       data: dto,
//     });
//     return updatedEvent as EventEntity;
//   }

//   async delete(id: number): Promise<boolean> {
//     const event = await this.prisma.event.findUnique({ where: { id } });
//     if (!event) return false;

//     await this.prisma.event.delete({ where: { id } });
//     return true;
//   }
// }

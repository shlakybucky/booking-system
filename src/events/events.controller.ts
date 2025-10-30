// src/events/events.controller.ts
import { Controller, Get, Post, Put, Delete, Param, Body } from '@nestjs/common';
import { EventsService } from './events.service';
import { CreateEventDto} from './dto/event.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Events')
@Controller('api/events')
export class EventsController {
  constructor(private readonly eventsService: EventsService) {}

  @Get()
  async getAll() {
    return this.eventsService.findAll();
  }

  @Get(':id')
  async getEventById(@Param('id') id: number) {
    return this.eventsService.findOne(id);
  }

  @Post()
  async create(@Body() dto: CreateEventDto) {
    return this.eventsService.create(dto);
  }

  @Delete(':id')
  async deleteEventById(@Param('id') id: number) {
    return this.eventsService.delete(id);
  }
}

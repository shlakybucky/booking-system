import { Controller, Post, Body, ConflictException, InternalServerErrorException } from '@nestjs/common';
import { BookingService } from './booking.service';
import { ReservationResult } from './booking.types';
import { BookingDto } from './dto/booking.dto';
import { BookingEntity } from './entities/booking.entity';
import { ApiTags, ApiResponse, ApiBody } from '@nestjs/swagger';

@ApiTags('Booking')
@Controller('api/booking')
export class BookingController {
  constructor(private readonly bookingService: BookingService) {}

  @Post('reserve')
  @ApiBody({ type: BookingDto })
  @ApiResponse({ status: 201, description: 'Booking created successfully', type: BookingEntity })
  @ApiResponse({ status: 409, description: 'Booking already exists' })
  @ApiResponse({ status: 500, description: 'Internal server error' })
  public async reserve(@Body() dto: BookingDto): Promise<BookingEntity> {
    try {
      const result: ReservationResult = await this.bookingService.reserve(dto.eventId, dto.userId);

      if (!result.success) {
        throw new ConflictException(result.message);
      }

      return result.booking;
    } catch (error) {
      console.error('Booking reservation error:', error);
      throw new InternalServerErrorException('Failed to process booking');
    }
  }

}
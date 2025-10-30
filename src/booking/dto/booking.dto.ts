import { IsInt, Min } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class BookingDto {
    @ApiProperty({ example: 1, description: 'ID мероприятия' })
    @IsInt()
    @Min(1)
    eventId!: number;

    @ApiProperty({ example: 123, description: 'ID пользователя' })
    @IsInt()
    @Min(1)
    userId!: number;
}
import { IsString, IsNotEmpty, IsInt, Min, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateEventDto {
  @ApiProperty({ example: 'Coldplay World Tour 2025', description: 'Название мероприятия' })
  @IsString()
  @IsNotEmpty()
  name!: string;

  @ApiProperty({ example: 50000, description: 'Общее количество мест' })
  @IsInt()
  @Min(1)
  totalSeats!: number;
}

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(new ValidationPipe({ 
    whitelist: true, 
    forbidNonWhitelisted: true 
  }));

  const config = new DocumentBuilder()
    .setTitle('Booking API')
    .setDescription('API для бронирования мероприятий')
    .setVersion('1.0')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);


  const port = process.env.APP_PORT || 3000;
  await app.listen(port, '0.0.0.0');

  console.log(`Application is running on: http://localhost:${port}`);
  // const port = process.env.APP_PORT ? parseInt(process.env.APP_PORT, 10) : 3000;
  // await app.listen(port, '0.0.0.0');

  // console.log(`Application is running on: http://localhost:${port}`);
  // console.log(`Swagger docs available at: http://localhost:${port}/api/docs`);
}
bootstrap();
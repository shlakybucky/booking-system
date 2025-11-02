import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { PrismaService } from '../src/prisma/prisma.service';

describe('BookingController (e2e)', () => {
  let app: INestApplication;
  let prisma: PrismaService;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(new ValidationPipe({ whitelist: true }));
    await app.init();

    prisma = app.get(PrismaService);

    // Чистим таблицы перед тестами
    await prisma.booking.deleteMany();
    await prisma.event.deleteMany();
  });

  afterAll(async () => {
    await prisma.$disconnect();
    await app.close();
  });

  describe('Event CRUD', () => {
    let eventId: number;

    it('should create an event', async () => {
      const res = await request(app.getHttpServer())
        .post('/api/events')
        .send({ name: 'Test Event', totalSeats: 10 })
        .expect(201);

      expect(res.body).toHaveProperty('id');
      eventId = res.body.id;
    });

    it('should get all events', async () => {
      const res = await request(app.getHttpServer()).get('/api/events').expect(200);
      expect(res.body.length).toBeGreaterThan(0);
    });

    it('should get event by id', async () => {
      const res = await request(app.getHttpServer())
        .get(`/api/events/${eventId}`)
        .expect(200);
      expect(res.body.id).toBe(eventId);
    });

    it('should delete event', async () => {
      await request(app.getHttpServer()).delete(`/api/events/${eventId}`).expect(200);
      await request(app.getHttpServer()).get(`/api/events/${eventId}`).expect(404);
    });
  });

  describe('Booking concurrent tests', () => {
    let eventId: number;

    beforeAll(async () => {
      const event = await prisma.event.create({ data: { name: 'Concurrent Event', totalSeats: 1 } });
      eventId = event.id;
    });

    it('should prevent double booking (row-level lock)', async () => {
      const bookingPayload = { eventId, userId: 1 };

      const results = await Promise.allSettled([
        request(app.getHttpServer()).post('/api/booking/reserve').send(bookingPayload),
        request(app.getHttpServer()).post('/api/booking/reserve').send(bookingPayload),
      ]);

      const fulfilled = results.filter(r => r.status === 'fulfilled') as any[];

      const successCount = fulfilled.filter(r => r.value.status === 201).length;
      const conflictCount = fulfilled.filter(r => r.value.status === 409).length;

      expect(successCount).toBe(1);
      expect(conflictCount).toBe(1);
    });
  });

  describe('Swagger docs', () => {
    it('should serve Swagger JSON', async () => {
      const res = await request(app.getHttpServer()).get('/api/docs-json').expect(200);
      expect(res.body).toHaveProperty('paths');
      expect(res.body.paths).toHaveProperty('/api/booking/reserve');
      expect(res.body.paths).toHaveProperty('/api/events');
    });
  });
});

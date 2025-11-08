import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database...');

  // Очистим таблицы (если нужно)
  await prisma.booking.deleteMany();
  await prisma.event.deleteMany();

  // Создаём больше событий
  const eventsData = [
    { name: 'Coldplay World Tour 2025 — London', totalSeats: 50000 },
    { name: 'Web Summit Lisbon 2025', totalSeats: 20000 },
    { name: 'AI & Robotics Expo 2025 — San Francisco', totalSeats: 8000 },
    { name: 'Local Startup Meetup — Berlin', totalSeats: 300 },
    { name: 'UX/UI Design Conference — Tokyo', totalSeats: 1200 },
    { name: 'Jazz Night — New Orleans', totalSeats: 400 },
    { name: 'Film Festival — Cannes', totalSeats: 2500 },
    { name: 'Comic Con — New York', totalSeats: 15000 },
    { name: 'Blockchain Summit — Singapore', totalSeats: 10000 },
    { name: 'Open Source Hackathon — Remote', totalSeats: 1000 },
    { name: 'Music Fest — LA', totalSeats: 6000 },
    { name: 'Startup Pitch Day — Paris', totalSeats: 800 },
    { name: 'HealthTech Expo — Zurich', totalSeats: 2000 },
    { name: 'Photography Workshop — Amsterdam', totalSeats: 100 },
    { name: 'VR World Congress — Seoul', totalSeats: 4000 },
    { name: 'Literature Fair — Madrid', totalSeats: 900 },
    { name: 'Food & Wine Expo — Milan', totalSeats: 5000 },
    { name: 'Gaming Convention — Warsaw', totalSeats: 7000 },
    { name: 'Film Awards — LA', totalSeats: 12000 },
    { name: 'Rock Festival — Sydney', totalSeats: 25000 },
  ];

  const events = await prisma.event.createMany({
    data: eventsData,
  });

  console.log(`✅ Created ${eventsData.length} events`);

  // Получаем все события
  const allEvents = await prisma.event.findMany();
  const eventIds = allEvents.map(e => e.id);

  // Создаём случайные бронирования
  const usersCount = 50;
  const bookingsToCreate = 500; // например, 500 бронирований

  const bookingsData = [];

  for (let i = 0; i < bookingsToCreate; i++) {
    const randomEventId = eventIds[Math.floor(Math.random() * eventIds.length)];
    const randomUserId = Math.ceil(Math.random() * usersCount);

    // создадим случайную дату бронирования за последний год
    const createdAt = new Date();
    createdAt.setDate(createdAt.getDate() - Math.floor(Math.random() * 365));

    bookingsData.push({
      eventId: randomEventId,
      userId: randomUserId,
      createdAt,
    });
  }

  await prisma.booking.createMany({
    data: bookingsData,
    skipDuplicates: true,
  });

  console.log(`✅ Created ${bookingsData.length} bookings`);
  console.log('🌿 Seeding completed successfully!');
}

main()
  .catch((e) => {
    console.error('❌ Seed error:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });







// import { PrismaClient } from '@prisma/client';

// const prisma = new PrismaClient();

// async function main() {
//   console.log('Seeding database...');

//   await prisma.event.createMany({
//     data: [
//       { name: 'Coldplay World Tour 2025 — London', totalSeats: 50000 },
//       { name: 'Web Summit Lisbon 2025', totalSeats: 20000 },
//       { name: 'AI & Robotics Expo 2025 — San Francisco', totalSeats: 8000 },
//       { name: 'Local Startup Meetup — Berlin', totalSeats: 300 },
//       { name: 'UX/UI Design Conference — Tokyo', totalSeats: 1200 },
//       { name: 'Jazz Night — New Orleans', totalSeats: 400 },
//       { name: 'Film Festival — Cannes', totalSeats: 2500 },
//       { name: 'Comic Con — New York', totalSeats: 15000 },
//       { name: 'Blockchain Summit — Singapore', totalSeats: 10000 },
//       { name: 'Open Source Hackathon — Remote', totalSeats: 1000 },
//     ],
//     skipDuplicates: true,
//   });

//   console.log('✅ Seed completed: created sample events');
// }

// main()
//   .catch((e) => {
//     console.error('❌ Seed error:', e);
//     process.exit(1);
//   })
//   .finally(async () => {
//     await prisma.$disconnect();
//   });

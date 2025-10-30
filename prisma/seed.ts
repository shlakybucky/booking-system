import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  await prisma.event.createMany({
    data: [
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
    ],
    skipDuplicates: true,
  });

  console.log('✅ Seed completed: created sample events');
}

main()
  .catch((e) => {
    console.error('❌ Seed error:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  await prisma.user.createMany({
    data: [
      {
        id: '1a2b3c4d-0000-0000-0000-000000000001',
        email: 'admin@example.com',
        password: 'hashedpassword',
        name: 'Admin User',
        isActive: true,
      },
      {
        id: '2b3c4d5e-0000-0000-0000-000000000002',
        email: 'user@example.com',
        password: 'hashedpassword',
        name: 'Normal User',
        isActive: true,
      },
    ],
  });
  console.log('🌱 Seed verisi başarıyla yüklendi.');
}

main()
  .catch(console.error)
  .finally(async () => {
    await prisma.$disconnect();
  });

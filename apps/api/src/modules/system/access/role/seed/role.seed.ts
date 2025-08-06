import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function seedRole() {
  await prisma.role.createMany({
    data: [{ name: 'admin' }, { name: 'teacher' }, { name: 'editor' }],
    skipDuplicates: true, // varsa tekrar etmesin
  });

  console.log('🌱 Role seed completed.');
}

// Çalıştırılabilir hâle getiriyoruz:
if (require.main === module) {
  seedRole()
    .catch((e) => {
      console.error('❌ Seed error:', e);
      process.exit(1);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });
}

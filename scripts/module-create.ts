// 🧱 TT Panel - Modül Oluşturucu (Minimal & Full)
// Kullanım:
//   make mc system/access/role           → minimal mod
//   make mc system/access/role full      → full mod

import { mkdirSync, writeFileSync } from 'fs';
import { basename } from 'path';
import pluralize from 'pluralize';

// 🎯 Parametreleri al
const path = process.argv[2];
const mode = process.argv[3] ?? 'minimal';

if (!path) {
  console.error('❌ Hata: path parametresi zorunludur (örn: system/access/role)');
  process.exit(1);
}

const name = basename(path); // örn: "role"
const plural = pluralize(name); // "role" → "roles", "category" → "categories"
const target = `apps/api/src/modules/${path}`;

console.log(`📁 Modül oluşturuluyor: ${target}`);

// 📁 Klasörleri oluştur
const basicDirs = ['controller', 'service', 'dto', 'entity', 'test', 'seed'];
const extraDirs = [
  'config',
  'guard',
  'policy',
  'pipe',
  'middleware',
  'helper',
  'factory',
  'validator',
  'interceptor',
];

for (const dir of basicDirs) mkdirSync(`${target}/${dir}`, { recursive: true });
if (mode === 'full') {
  for (const dir of extraDirs) {
    mkdirSync(`${target}/${dir}`, { recursive: true });
    writeFileSync(`${target}/${dir}/.gitkeep`, '');
  }
}

// 📄 Dosya içerikleri
const upper = name[0].toUpperCase() + name.slice(1);

writeFileSync(
  `${target}/${name}.module.ts`,
  `
import { Module } from '@nestjs/common';
import { ${upper}Service } from './service/${name}.service';
import { ${upper}Controller } from './controller/${name}.controller';

@Module({
  controllers: [${upper}Controller],
  providers: [${upper}Service],
})
export class ${upper}Module {}
`.trimStart(),
);

writeFileSync(
  `${target}/service/${name}.service.ts`,
  `
import { Injectable } from '@nestjs/common';

@Injectable()
export class ${upper}Service {
  findAll() {
    return [];
  }
}
`.trimStart(),
);

writeFileSync(
  `${target}/controller/${name}.controller.ts`,
  `
import { Controller, Get } from '@nestjs/common';
import { ${upper}Service } from '../service/${name}.service';

@Controller('${plural}')
export class ${upper}Controller {
  constructor(private readonly ${name}Service: ${upper}Service) {}

  @Get()
  findAll() {
    return this.${name}Service.findAll();
  }
}
`.trimStart(),
);

writeFileSync(
  `${target}/dto/create-${name}.dto.ts`,
  `
export class Create${upper}Dto {
  // name: string;
}
`.trimStart(),
);

writeFileSync(
  `${target}/dto/update-${name}.dto.ts`,
  `
export class Update${upper}Dto {
  // id: number;
  // name?: string;
}
`.trimStart(),
);

writeFileSync(
  `${target}/test/${name}.service.spec.ts`,
  `
import { Test, TestingModule } from '@nestjs/testing';
import { ${upper}Service } from '../service/${name}.service';

describe('${upper}Service', () => {
  let service: ${upper}Service;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [${upper}Service],
    }).compile();

    service = module.get<${upper}Service>(${upper}Service);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('findAll should return empty array', () => {
    expect(service.findAll()).toEqual([]);
  });
});
`.trimStart(),
);

writeFileSync(
  `${target}/seed/${name}.seed.ts`,
  `
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function seed${upper}() {
  await prisma.${name}.createMany({
    data: [
      // { name: 'Örnek Veri' },
    ],
    skipDuplicates: true,
  });

  console.log('🌱 ${upper} seed completed.');
}

if (require.main === module) {
  seed${upper}()
    .catch((e) => {
      console.error('❌ Seed error:', e);
      process.exit(1);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });
}
`.trimStart(),
);

writeFileSync(
  `${target}/entity/${name}.entity.ts`,
  `
export class ${upper}Entity {
  // ...
}
`.trimStart(),
);

console.log(`✅ ${mode} modunda modül yapısı ve içerikler oluşturuldu: ${target}`);

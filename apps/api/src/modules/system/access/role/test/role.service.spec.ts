import { Test, TestingModule } from '@nestjs/testing';
import { RoleService } from '../service/role.service';
import { PrismaService } from '@/infra/prisma/prisma.service';

describe('RoleService', () => {
  let service: RoleService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        RoleService,
        {
          provide: PrismaService,
          useValue: {
            role: {
              create: jest.fn().mockResolvedValue({ id: 1, name: 'Admin' }),
              findMany: jest.fn().mockResolvedValue([{ id: 1, name: 'Admin' }]),
            },
          },
        },
      ],
    }).compile();

    service = module.get<RoleService>(RoleService);
  });

  it('servis tanımlı olmalı', () => {
    expect(service).toBeDefined();
  });

  it('yeni rol oluşturmalı', async () => {
    const dto = { name: 'Admin' };
    const result = await service.create(dto);
    expect(result).toEqual({ id: 1, name: 'Admin' });
  });

  it('tüm rolleri getirmeli', async () => {
    const result = await service.findAll();
    expect(result).toEqual([{ id: 1, name: 'Admin' }]);
  });
});

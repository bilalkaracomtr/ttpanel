import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './infra/prisma/prisma.module'
import { HealthModule } from './modules/system/services/health/health.module';
import { RoleModule } from './modules/system/access/role/role.module';

@Module({
  imports: [ConfigModule.forRoot({ isGlobal: true }), PrismaModule, HealthModule, RoleModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

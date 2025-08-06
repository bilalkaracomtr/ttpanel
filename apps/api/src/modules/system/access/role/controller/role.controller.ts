import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Put,
  Delete,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiResponse } from '@nestjs/swagger';
import { RoleService } from '../service/role.service';
import { CreateRoleDto } from '../dto/create-role.dto';
import { UpdateRoleDto } from '../dto/update-role.dto';

@Controller('roles')
export class RoleController {
  constructor(private readonly roleService: RoleService) {}

  @Post()
  @ApiResponse({ status: 201, description: 'Role başarıyla oluşturuldu.' })
  create(@Body() dto: CreateRoleDto) {
    return this.roleService.create(dto);
  }

  @Get()
  @ApiResponse({ status: 200, description: 'Tüm roller listelendi.' })
  findAll() {
    return this.roleService.findAll();
  }

  @Get(':id')
  @ApiResponse({ status: 200, description: 'ID ile Role bulundu.' })
  @ApiResponse({ status: 404, description: 'Role bulunamadı.' })
  findOne(@Param('id') id: string) {
    return this.roleService.findOne(id);
  }

  @Put(':id')
  @ApiResponse({ status: 200, description: 'Role başarıyla güncellendi.' })
  update(@Param('id') id: string, @Body() dto: UpdateRoleDto) {
    return this.roleService.update(id, dto);
  }

  @Delete(':id')
  @ApiResponse({ status: 204, description: 'Role başarıyla silindi.' })
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id') id: string) {
    return this.roleService.remove(id);
  }
}

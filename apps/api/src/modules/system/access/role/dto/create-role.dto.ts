import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsString, IsOptional, Length } from 'class-validator';
export class CreateRoleDto {
  @ApiProperty({ description: 'Role adı', maxLength: 100 })
  @IsString()
  @Length(3, 100)
  name: string;

  @ApiPropertyOptional({ description: 'Role açıklaması', maxLength: 255 })
  @IsOptional()
  @IsString()
  @Length(0, 255)
  description?: string;
}

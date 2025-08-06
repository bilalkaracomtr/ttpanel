// 🔗 TT Panel - AppModule Otomatik Modül Kaydedici
// Kullanım:
//   make mr system/access/role

import fs from 'fs';
import path from 'path';

const args = process.argv.slice(2);
const rawPath = args[0]; // örn: system/access/role

if (!rawPath) {
  console.error('❌ path parametresi zorunludur. Örn: system/access/role');
  process.exit(1);
}

const moduleName = path.basename(rawPath); // role
const className = `${moduleName.charAt(0).toUpperCase()}${moduleName.slice(1)}Module`; // RoleModule
const importPath = `./modules/${rawPath}/${moduleName}.module`;

const appModulePath = 'apps/api/src/app.module.ts';
let content = fs.readFileSync(appModulePath, 'utf8');

// ✅ 1. Import satırını ekle
const importStatement = `import { ${className} } from '${importPath}';`;
if (!content.includes(importStatement)) {
  const lastImportIndex = [...content.matchAll(/^import .+;$/gm)].pop()?.index ?? 0;
  const insertAt = content.indexOf('\n', lastImportIndex) + 1;
  content = content.slice(0, insertAt) + importStatement + '\n' + content.slice(insertAt);
  console.log(`✅ Import eklendi: ${className}`);
} else {
  console.log(`ℹ️ Import zaten var: ${className}`);
}

// ✅ 2. imports: [ ... ] bloğuna ekle
const moduleIndex = content.indexOf('@Module({');
const importsIndex = content.indexOf('imports:', moduleIndex);
if (importsIndex === -1) {
  console.error('❌ imports: bloğu bulunamadı.');
  process.exit(1);
}

const bracketStart = content.indexOf('[', importsIndex);
const bracketEnd = content.indexOf(']', bracketStart);
const importsBlock = content.slice(bracketStart + 1, bracketEnd);

if (!importsBlock.includes(className)) {
  const trimmed = importsBlock.trim();
  const needsComma = trimmed.length > 0 && !trimmed.endsWith(',');
  const insertValue = `${needsComma ? ',' : ''} ${className}`;

  const before = content.slice(0, bracketEnd);
  const after = content.slice(bracketEnd);
  content = before + insertValue + after;

  console.log(`✅ imports[] içine eklendi: ${className}`);
} else {
  console.log(`ℹ️ imports[] içinde zaten var: ${className}`);
}

fs.writeFileSync(appModulePath, content, 'utf8');
console.log('✅ AppModule güncellendi.');

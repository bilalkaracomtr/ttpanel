// 🔗 TT Panel - AppModule Otomatik Modül Kaydedici
// Kullanım:
//   make mr system/access/role

import fs from "fs";
import path from "path";

const args = process.argv.slice(2);
const rawPath = args[0]; // örn: system/access/role

if (!rawPath) {
  console.error("❌ path parametresi zorunludur. Örn: system/access/role");
  process.exit(1);
}

const moduleName = path.basename(rawPath); // role
const className = `${moduleName.charAt(0).toUpperCase()}${moduleName.slice(1)}Module`; // RoleModule
const importPath = `@modules/${rawPath}/${moduleName}.module`;

const appModulePath = "apps/api/src/app.module.ts";
let content = fs.readFileSync(appModulePath, "utf8");

// 🔍 Import zaten var mı?
const importStatement = `import { ${className} } from '${importPath}';`;
if (!content.includes(importStatement)) {
  const importIndex = content.lastIndexOf("import ");
  const nextLineIndex = content.indexOf("\n", importIndex);
  content =
    content.slice(0, nextLineIndex + 1) +
    importStatement +
    "\n" +
    content.slice(nextLineIndex + 1);
  console.log(`✅ Import eklendi: ${className}`);
} else {
  console.log(`ℹ️ Import zaten var: ${className}`);
}

// 🔍 imports: [ ... ] bloğunda var mı?
const moduleStart = content.indexOf("@Module({");
const importsStart = content.indexOf("imports:", moduleStart);
const importsEnd = content.indexOf("]", importsStart);
const importsBlock = content.slice(importsStart, importsEnd);

if (!importsBlock.includes(className)) {
  const insertionPoint = importsEnd;
  content =
    content.slice(0, insertionPoint) +
    `  ${className},\n` +
    content.slice(insertionPoint);
  console.log(`✅ imports[] içine eklendi: ${className}`);
} else {
  console.log(`ℹ️ imports[] içinde zaten var: ${className}`);
}

fs.writeFileSync(appModulePath, content, "utf8");
console.log("✅ AppModule güncellendi.");

// 🌱 TT Panel - Modül Seed Çalıştırıcı
// Kullanım:
//   make ms system/access/role

import { basename } from "path";
import { execSync } from "child_process";

const path = process.argv[2];

if (!path) {
  console.error(
    "❌ Hata: path parametresi zorunludur (örn: system/access/role)"
  );
  process.exit(1);
}

const name = basename(path);
const target = `modules/${path}/seed/${name}.seed.ts`;

console.log(`🌱 Seed çalıştırılıyor → ${target}`);

try {
  execSync(`docker compose exec api npx ts-node -P tsconfig.json ${target}`, {
    stdio: "inherit",
  });
  console.log("✅ Seed işlemi tamamlandı.");
} catch (err) {
  console.error("❌ Seed işlemi başarısız oldu.");
  process.exit(1);
}

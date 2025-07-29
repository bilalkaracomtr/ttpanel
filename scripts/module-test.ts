// 🧪 TT Panel - Modül Test Çalıştırıcı
// Kullanım:
//   make mt system/access/role

import { existsSync } from "fs";
import { execSync } from "child_process";

const path = process.argv[2];

if (!path) {
  console.error(
    "❌ Hata: path parametresi zorunludur (örn: system/access/role)"
  );
  process.exit(1);
}

const target = `modules/${path}/test`;

if (!existsSync(target)) {
  console.error(`❌ Test klasörü bulunamadı: ${target}`);
  process.exit(1);
}

console.log(`🧪 Testler çalıştırılıyor → ${target}`);

try {
  execSync(`docker compose exec api npx vitest run ${target}`, {
    stdio: "inherit",
  });
  console.log("✅ Testler tamamlandı.");
} catch (err) {
  console.error("❌ Testler başarısız oldu.");
  process.exit(1);
}

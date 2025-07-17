# Temel imaj
FROM node:22

# Zaman dilimi ayarı için ortam
ENV TZ=Europe/Istanbul

# Çalışma klasörü
WORKDIR /app

# Paket dosyalarını yükle
COPY package*.json ./
RUN npm install

# Tüm proje dosyalarını kopyala
COPY . .

# Portu aç
EXPOSE 3000

# Uygulama başlat
CMD ["npm", "run", "start:dev"]
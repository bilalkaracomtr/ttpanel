FROM node:22

WORKDIR /app

ENV TZ=Europe/Istanbul

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3002

CMD ["npm", "run", "dev"]
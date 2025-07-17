FROM node:22

WORKDIR /app

ENV TZ=Europe/Istanbul

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3001

CMD ["npm", "run", "dev"]
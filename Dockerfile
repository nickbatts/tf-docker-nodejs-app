FROM node:alpine

WORKDIR /app

COPY package.json index.js ./

#RUN npm install

EXPOSE 3000

USER node

CMD ["node","index.js"]
FROM node:18-alpine as remix
RUN apk update
RUN apk add yarn
ENV NODE_ENV production
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn
COPY . .
EXPOSE 3000
CMD ["yarn", "start"]

FROM nginx:latest as nginx
RUN apt update
RUN apt install neovim -y
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
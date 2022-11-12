# build stage
FROM node:16 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY --from=build-stage /app/welcomePage /usr/share/nginx/html/welcomePage
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
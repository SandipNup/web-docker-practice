#specify base image
#here as represents the tag every step from below this is tagged as builder phase
FROM node:alpine as builder

WORKDIR /app

COPY ./package.json ./


#Install dependency 
RUN npm install 

COPY ./ ./

RUN npm run build
#it is going to create build folder in /app/build

ENV CI=true


#to specify next we just need to specify another base image 
FROM nginx
#here we are not using any of the other folders then build we just need this folder
COPY --from=builder /app/build /usr/share/nginx/html


#here in this docker file we creating two set of layers and we are just copying build folder 
#from the previous layer to nginx layer
#when second FROM statement is defined previous block of statement will all be stopped or closed
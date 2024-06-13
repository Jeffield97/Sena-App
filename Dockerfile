#Imagen base
FROM node:16-alpine AS build

#Establecer el directorio raiz
WORKDIR /app

#Copiar el package.json
COPY package*.json ./

#Instalar dependencias del proyecto
RUN npm install

#Copiar codigo fuente
COPY . .

#Construir la app angular
RUN npm run build --prod

#Levantar la aplicacion angular
FROM nginx:alpine

# Copiar los archivos construidos desde la etapa de construcción
COPY --from=build /app/dist/sena-app /usr/share/nginx/html

#Exponer el puerto del contenedor
EXPOSE 80

#Ejecutar el servidor nginx
CMD ["nginx", "-g", "daemon off;"]
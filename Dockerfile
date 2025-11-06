# Utiliser une image Nginx légère
FROM nginx:alpine

# Copier les fichiers de votre site statique dans le répertoire de Nginx
COPY . /usr/share/nginx/html

# Le conteneur écoutera sur le port 80 par défaut (défini par l'image nginx:alpine)
EXPOSE 80

# Démarrer Nginx (défini par l'image de base)
CMD ["nginx", "-g", "daemon off;"]
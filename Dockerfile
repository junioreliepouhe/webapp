# Étape 1 : Image officielle Nginx (petite et sécurisée)
FROM nginx:alpine

# Étape 2 : Supprimer le contenu par défaut
RUN rm -rf /usr/share/nginx/html/*

# Étape 3 : Copier uniquement les fichiers utiles du site
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

# Étape 4 : Exposer le port 80
EXPOSE 80

# Étape 5 : Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]

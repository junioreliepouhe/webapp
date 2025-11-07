# Étape 1 : Utiliser l'image officielle de Nginx comme base (petite et sécurisée)
FROM nginx:alpine

# Étape 2 : Supprimer le répertoire de contenu par défaut de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Étape 3 : Copier votre contenu (index.html, style.css, etc.) dans le répertoire Nginx
# Les fichiers doivent être à la racine de votre dépôt Git
COPY . /usr/share/nginx/html/

# Étape 4 : Exposer le port par défaut de Nginx (80)
EXPOSE 80

# Étape 5 : Commande pour lancer Nginx et le maintenir en arrière-plan
# Cette commande empêche le conteneur de s'arrêter immédiatement
CMD ["nginx", "-g", "daemon off;"]

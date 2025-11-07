# Étape 1 : Utiliser l'image officielle de Nginx comme base
FROM nginx:alpine

# Étape 2 : Supprimer le répertoire de contenu par défaut de Nginx
# Le serveur web s'attend à trouver le contenu ici.
RUN rm -rf /usr/share/nginx/html/*

# Étape 3 : Copier votre contenu (index.html, style.css) dans le répertoire Nginx
# Les fichiers index.html et style.css doivent être à la racine de votre dépôt.
COPY . /usr/share/nginx/html/

# Étape 4 : Exposer le port par défaut de Nginx (80)
EXPOSE 80

# Étape 5 : Commande pour lancer Nginx et le maintenir en arrière-plan
# C'est cette ligne qui fait que le conteneur ne s'arrête pas !
CMD ["nginx", "-g", "daemon off;"]

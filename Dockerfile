# Utilise une image Node stable basée sur Debian Buster
FROM node:lts-buster

# Installe les dépendances système nécessaires
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    webp && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Définir le dossier de travail
WORKDIR /usr/src/app

# Copier uniquement les fichiers nécessaires à l'installation
COPY package*.json ./

# Installer les dépendances
RUN npm install && npm install -g qrcode-terminal pm2

# Copier le reste du code de l'application
COPY . .

# Exposer le port sur lequel l'appli tourne
EXPOSE 5000

# Démarrer l'application
CMD ["npm", "start"]

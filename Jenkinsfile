pipeline {
    agent any
    
    // =======================================================
    // ⚙️ VOS VARIABLES ET CREDENTIALS
    // =======================================================
    environment {
        // L'ID de vos identifiants Slack créé dans Jenkins
        SLACK_CREDS = credentials('slack-token') /
        
        // Le canal Slack de destination
        SLACK_CHANNEL = '#jenkins-alerts' 
        
        // Votre URL GitHub (déjà configurée)
        GITHUB_URL = 'https://github.com/juniorieliepouhe/webapp.git'
    }

    // Déclenchement (Poll SCM toutes les 5 min)
    triggers {
        pollSCM('H/5 * * * *')
    }

    // =======================================================
    // 🏗️ STAGES DU PIPELINE CI/CD
    // =======================================================
    stages {
        
        stage('1. Clone') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'good', message: "🚀 Pipeline *${env.JOB_NAME}* - Étape *Clone* démarrée...")
                git branch: 'dev', url: env.GITHUB_URL
            }
        }
        
        stage('2. Build') { // UTILISATION DE DOCKER RÉEL
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'warning', message: "🛠️ Pipeline *${env.JOB_NAME}* - Étape *Build* en cours : Création de l'image Docker.")
                script {
                    echo "Démarrage de la construction de l'image Docker..."
                    // Commande Docker réelle : construit l'image et la tagge avec le numéro de build
                    // Le "." signifie : cherche le Dockerfile dans le répertoire courant (qui vient d'être cloné)
                    sh "docker build -t webapp-image:${env.BUILD_NUMBER} ." 
                    echo "Image webapp-image:${env.BUILD_NUMBER} créée."
                }
            }
        }
        
        stage('3. Deploy (SIMULATION Avancée)') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: '#007FFF', message: "🌐 Pipeline *${env.JOB_NAME}* - Étape *Deploy* en cours : Déploiement du conteneur ${env.BUILD_NUMBER}.")
                script {
                    echo "Démarrage de la simulation de déploiement de l'image webapp-image:${env.BUILD_NUMBER}"
                    // SIMULATION : Arrêter et supprimer l'ancien conteneur s'il existe
                    sh 'docker stop webapp-container || true' 
                    sh 'docker rm webapp-container || true' 
                    // SIMULATION : Démarrer le nouveau conteneur sur le port 8081 avec l'image fraîchement construite
                    sh "docker run -d --name webapp-container -p 8081:80 webapp-image:${env.BUILD_NUMBER}" 
                    echo "Application déployée sur http://localhost:8081"
                }
            }
        }
    }
    
    // =======================================================
    // 🔔 ACTIONS POST-BUILD (Toujours notifier, qu'il y ait erreur ou succès)
    // =======================================================
    post {
        always {
            // Envoyer la notification finale
            slackSend(
                channel: env.SLACK_CHANNEL,
                color: currentBuild.result == 'SUCCESS' ? 'good' : 'danger',
                message: "*${env.JOB_NAME}* - Build #${env.BUILD_NUMBER} : ${currentBuild.result} ! (Durée: ${currentBuild.durationString})"
            )
        }
    }
}

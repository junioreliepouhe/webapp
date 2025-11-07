pipeline {
    agent any

    environment {
        // 1. !!! REMPLACER 'slack-token-ID-reel' par l'ID réel créé dans Jenkins (probablement 'slack-token') !!!
        SLACK_CREDS = 'slack-token' 
        
        // 2. !!! REMPLACER '#votre-canal-reel' par le nom de votre canal Slack (ex: '#ci-cd-junior') !!!
        SLACK_CHANNEL = '#votre-canal-slack' 
    }

    // Déclenchement (Sonde le SCM toutes les 5 min)
    triggers {
        pollSCM('H/5 * * * *') 
    }
    
    // N'exécute le pipeline que si la branche est 'dev'
    when {
        branch 'dev'
    }

    stages {
        stage('1. Clone') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'good', message: "🚀 Pipeline *${env.JOB_NAME}* - Étape *Clone* démarrée. Récupération du code sur la branche *dev*.")
                // Votre URL GitHub
                git branch: 'dev', url: "https://github.com/junioreliepouhe/webapp.git"
            }
        }
        
        stage('2. Build (SIMULATION)') { 
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'warning', message: "🛠️ Pipeline *${env.JOB_NAME}* - Étape *Build* en cours (SIMULATION de création d'image Docker).")
                script {
                    echo "Démarrage de la simulation de la construction de l'image Docker..."
                    // Simuler le temps de build
                    sh 'sleep 5' 
                    // Simuler la création d'un artefact
                    sh 'echo "Image webapp-image:${env.BUILD_NUMBER} créée (Simulation)." > build_artefact.txt'
                }
            }
        }
        
        stage('3. Deploy (SIMULATION)') { 
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: '#007FFF', message: "🌐 Pipeline *${env.JOB_NAME}* - Étape *Deploy* en cours (SIMULATION de déploiement de conteneur).")
                script {
                    echo "Démarrage de la simulation de déploiement..."
                    // Simuler l'arrêt de l'ancien conteneur
                    sh 'echo "Simulating stopping old container webapp-container..."'
                    sh 'sleep 3'
                    // Simuler le démarrage du nouveau conteneur
                    sh 'echo "Application déployée en environnement de test (Simulation sur port 8080)." '
                }
            }
        }
    }
    
    post {
        always {
            // Notification de fin (Succès ou Échec)
            slackSend(
                channel: env.SLACK_CHANNEL, 
                color: currentBuild.result == 'SUCCESS' ? 'good' : 'danger', 
                message: "🎉 Pipeline *${env.JOB_NAME}* - Build #${env.BUILD_NUMBER} **${currentBuild.result}** !"
            )
        }
    }
}

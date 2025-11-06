pipeline {
    agent any

    environment {
        // !!! A REMPLACER par l'ID de votre Credential Slack (ex: 'slack-token') !!!
        SLACK_CREDS = 'votre-slack-credential-id' 
        // !!! A REMPLACER par le nom de votre canal Slack (ex: '#devops-notifications') !!!
        SLACK_CHANNEL = '#votre-canal-slack' 
    }

    // Déclenchement (Poll SCM toutes les 5 min)
    triggers {
        pollSCM('H/5 * * * *') 
    }
    
    // N'exécute le pipeline que sur la branche 'dev'
    when {
        branch 'dev'
    }

    stages {
        stage('1. Clone') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'good', message: "Pipeline *${env.JOB_NAME}* - Étape *Clone* démarrée.")
                // Votre URL GitHub
                git branch: 'dev', url: "https://github.com/junioreliepouhe/webapp.git"
            }
        }
        
        stage('2. Build (SIMULATION)') { 
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'warning', message: "Pipeline *${env.JOB_NAME}* - Étape *Build* en cours (SIMULATION de création d'image Docker).")
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
                slackSend(channel: env.SLACK_CHANNEL, color: 'danger', message: "Pipeline *${env.JOB_NAME}* - Étape *Deploy* en cours (SIMULATION de déploiement de conteneur).")
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
            slackSend(
                channel: env.SLACK_CHANNEL, 
                color: currentBuild.result == 'SUCCESS' ? 'good' : 'danger', 
                message: "Pipeline *${env.JOB_NAME}* - Build #${env.BUILD_NUMBER} *${currentBuild.result}* !"
            )
        }
    }
}
pipeline {
    agent any

    environment {
        // !!! A REMPLACER par l'ID de votre Credential Slack !!!
        SLACK_CREDS = 'votre-slack-credential-id' 
        // !!! A REMPLACER par le nom de votre canal Slack !!!
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
        
        stage('2. Build (Docker Image)') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'warning', message: "Pipeline *${env.JOB_NAME}* - Étape *Build* en cours.")
                script {
                    docker.build("webapp-image:${env.BUILD_NUMBER}")
                }
            }
        }
        
        stage('3. Deploy') {
            steps {
                slackSend(channel: env.SLACK_CHANNEL, color: 'danger', message: "Pipeline *${env.JOB_NAME}* - Étape *Deploy* en cours.")
                script {
                    // Arrêter/supprimer l'ancien et démarrer le nouveau
                    sh "docker stop webapp-container || true"
                    sh "docker rm webapp-container || true"
                    sh "docker run -d -p 8080:80 --name webapp-container webapp-image:${env.BUILD_NUMBER}"
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
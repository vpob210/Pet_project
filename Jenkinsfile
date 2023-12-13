pipeline {
    agent any

    environment {
        REMOTE_HOST = '192.168.66.195'
        REMOTE_USER = 'jenkins'
    }

    stages {
        stage('SSH and Wall') {
            steps {
                script {
                    sshagent(['ssh-credentials-id']) {
                        // Команда, которую нужно выполнить
                        def command = 'wall "Hello from Jenkins!"'

                        // Выполняем команду по SSH
                        sh "ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} '${command}'"
                    }
                }
            }
        }
    }
}

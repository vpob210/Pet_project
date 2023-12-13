pipeline {
    agent any

    environment {
        REMOTE_HOST = '192.168.66.195'
        REMOTE_USER = 'jenkins'
        PROJECT_FOLDER = 'Pet_project'
    }

    stages {
        stage('Clone Project') {
            steps {
                script {
                    // Шаг клонирования проекта
                    checkout scm
                }
            }
        }

        stage('Copy to Remote Server') {
            steps {
                script {
                    sshagent(['ssh-pet-id']) {
                        // Команда копирования проекта на удаленный сервер с использованием rsync
                        def command = "rsync -r ${PROJECT_FOLDER}/ ${REMOTE_USER}@${REMOTE_HOST}:~/"

                        // Перед выполнением команды проверяем наличие папки
                        script {
                            def remoteDirExists = sh(script: "[ -d ~/Pet_project ] && echo 'true' || echo 'false'", returnStatus: true).trim() == 'true'

                            if (!remoteDirExists) {
                                // Если папка не существует, создаем ее
                                sh "ssh ${REMOTE_USER}@${REMOTE_HOST} 'mkdir ~/Pet_project'"
                            }
                        }

                        // Выполняем команду по SSH
                        sh command
                    }
                }
            }
        }
    }
}

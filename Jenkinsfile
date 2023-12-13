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
                        // Формируем полный путь к папке Pet_project
                        def localPath = "${WORKSPACE}/${PROJECT_FOLDER}/"
                        
                        // Команда копирования проекта на удаленный сервер с использованием rsync
                         def command = """
                            cd ${localPath} &&
                            rsync -r -C ${localPath}. ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/${PROJECT_FOLDER}/
                        """

                        // Перед выполнением команды проверяем наличие папки
                        script {
                            def remoteDirExists = sh(script: "ssh ${REMOTE_HOST} '[ -d /home/${REMOTE_USER}/Pet_project ] && echo true || echo false'", returnStdout: true).trim() == 'true'

                            if (!remoteDirExists) {
                                // Если папка не существует, создаем ее
                                sh "ssh ${REMOTE_HOST} 'mkdir ~/Pet_project'"
                            }
                        }

                        // Выполняем команду по SSH
                        dir(localPath) {
                            sh command
                        }
                    }
                }
            }
        }
    }
}

pipeline {
    agent any

    environment {
        REMOTE_HOST = '192.168.66.195'
        REMOTE_USER = 'jenkins'
        PROJECT_FOLDER = 'Pet_project'
    }

    stages {
        stage('Check Workspace Content') {
            steps {
                script {
                    // Вывести содержимое рабочей директории перед клонированием
                    sh "ls -lah ${WORKSPACE}"
                }
            }
        }
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
                        // Перед выполнением команды проверяем наличие папки
                        script {
                            def remoteDirExists = sh(script: "ssh ${REMOTE_HOST} '[ -d /home/${REMOTE_USER}/Pet_project ] && echo true || echo false'", returnStdout: true).trim() == 'true'

                            if (!remoteDirExists) {
                                // Если папка не существует, создаем ее
                                sh "ssh ${REMOTE_HOST} 'mkdir ~/Pet_project'"
                            }

                            script {
                            sh "ls -lah \${WORKSPACE}"
                        }
      
                        // Команда копирования проекта на удаленный сервер с использованием rsync
                             def localPath = "${WORKSPACE}"
                                  def command = """
                                    cd ${localPath} &&
                                    rsync -r -C --delete --exclude=mysql-data ${WORKSPACE}/. ${REMOTE_HOST}:/home/${REMOTE_USER}/${PROJECT_FOLDER}/
                                    """

                        // Выполняем команду по SSH
                        dir(localPath) {
                            sh command
                        }
                    }
                }
            }
        }
    }
        stage('start Docker compouse') {
            steps {
                script {
                    sshagent(['ssh-pet-id']) {
                    // Запуск контейнеров проекта
                    def stopDocker = 'cd Pet_project/ && docker-compose down'
                    def startDocker = 'docker-compose up --build -d'

                    sh "ssh ${REMOTE_HOST} '${stopDocker} && ${startDocker}'"
                    }
                }
            }
        }
   }
}

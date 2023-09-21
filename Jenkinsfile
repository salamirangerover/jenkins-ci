pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t chatcord .'
            }
        }

	stage('Run') {
            steps {
                // Запуск приложения, например:
                sh 'docker run -d -p 8080:8080 <имя_образа>'
            }
        }
    }
}

pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t chatcord .'
            }
        }

        stage('Smoke Test') {
            agent {
                docker { image 'chatcord' }
            }
            steps {
                sh 'node --version'
                sleep 10
            }
        }
    }
}

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
                sh 'docker run --rm -p 3005:3001 chatcord'
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

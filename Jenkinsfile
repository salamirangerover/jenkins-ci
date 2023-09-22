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

        stage('Run') {
            steps {
                sh 'docker run --rm -p 3005:3001 chatcord'
                sleep 10
            }
        }

        stage('Wait for Availability') {
            steps {
                script {
                    waitUntil {
                        def response = sh(returnStdout: true, script: 'curl -sL -w "%{http_code}" http://localhost:3005 -o /dev/null').trim()
                        return response == '200'
                    }
                }
            }
        }

        stage('Stop') {
            steps {
                sh 'docker rm -f chatcord'
            }
        }
       
    }
}

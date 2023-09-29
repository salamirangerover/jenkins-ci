pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t chatcord .'
            }
        }

	stage('Scan') {
	    steps {
		sh 'trivy chatcord'
	}
     
    }
}

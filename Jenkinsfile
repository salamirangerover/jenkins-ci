pipeline {
    agent any
    
    environment {
        IMAGE_NAME = 'salamirangerover/chatcord_distroless'
        BUILD_NUMBER = 'latest'
    }

    stages {
        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('Scan') {
            steps {
                // Install trivy
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.18.3'
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

                sh "trivy --no-progress --severity HIGH,CRITICAL ${IMAGE_NAME}:${BUILD_NUMBER}"
	    }
	}
    }
}

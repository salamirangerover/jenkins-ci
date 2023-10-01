pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t salamirangerover/chatcord:latest .'
            }
        }

	stage('Scan') {
	    steps {
             // Install trivy
            sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
            sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

            // Scan and report
            sh 'trivy --no-progress --exit-code 1 --severity CRITICAL salamirangerover/chatcord:latest'

	    }
     
    }
}

}
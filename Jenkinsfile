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
             // Install trivy
            sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
            sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

            // Scan and report
            sh 'mkdir -p reports'
            sh 'trivy image --ignore-unfixed --format template --template "@html.tpl" -o reports/nodjs-scan.html chatcord'
            publishHTML target : [
                allowMissing: true,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'reports',
                reportFiles: 'nodjs-scan.html',
                reportName: 'Trivy Scan',
                reportTitles: 'Trivy Scan'
            ]

	    }
     
    }
}

}
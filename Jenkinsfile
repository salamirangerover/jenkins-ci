pipeline {
    agent any
    
    environment {
        // GOOGLE_APPLICATION_CREDENTIALS = credentials('gcpmalko')
        GCP_LOCATION = 'europe-west1'
        IMAGE_NAME = 'chatcord'
        ARTIFACT_REPOSITORY = 'gcpmalko-docker-repo'
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
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

                // Scan and report
                sh "trivy --no-progress --severity HIGH,CRITICAL ${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }

        stage('Push to Artifact Registry') {
            steps {
                sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
                sh "gcloud auth configure-docker"
                sh "docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${GCP_LOCATION}/${ARTIFACT_REPOSITORY}/${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "docker push ${GCP_LOCATION}/${ARTIFACT_REPOSITORY}/${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    }
}
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
                script {
                    // Проверяем, установлен ли Trivy
                    def trivyInstalled = sh(returnStatus: true, script: 'which trivy').status == 0
                    
                    if (trivyInstalled) {
                        // Trivy уже установлен, выполняем сканирование образа chatcord
                        sh 'trivy image chatcord'
                    } else {
                        // Trivy не установлен, устанавливаем его и затем выполняем сканирование образа chatcord
                        sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
                        sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'    
                        sh 'trivy image chatcord'
                    }
                }
            }
        }     
    }
}
pipeline {
    agent any



    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run tests and collect test results
                sh 'mvn test' // Modify the test command as needed

                // Archive test results for Jenkins to display
                junit '**/target/surefire-reports/*.xml'
            }
        }
            stage('SonarQube Analysis') {
              def mvn = tool 'Default Maven';
              withSonarQubeEnv() {
                sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=devops-project -Dsonar.projectName='devops-project'"
              }
            }

    }

    post {
        success {
            echo 'Build and tests successful!'
        }

        failure {
            echo 'Build and tests failed. Please investigate.'
        }
    }
}

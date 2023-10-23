pipeline {
    agent any

    tools {
        // Define the JDK tool for Java 8
        jdk 'java8' // Replace 'Java8' with your Java 8 tool name
    }

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
           stage('Build and Analyze') {
                      steps {
                           script {
                               // Run the SonarQube analysis
                               sh 'mvn clean verify sonar:sonar ' +
                                  '-Dsonar.projectKey=sonar ' +
                                  '-Dsonar.projectName=\'sonar\' ' +
                                  '-Dsonar.host.url=http://192.168.33.10:9000 ' +
                                  '-Dsonar.token=sqp_890d6702edbe35a5b006df8975b5271b01c399d9'
                           }
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

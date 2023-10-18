pipeline {
    agent any

    tools {
        // Define the JDK tool for Java 8
        jdk 'Java8' // Replace 'Java8' with your Java 8 tool name
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

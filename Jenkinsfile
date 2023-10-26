pipeline {
    agent any

    tools {
        nodejs 'node'
    }

    stages {
        stage('Checkout Backend code') {
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
                sh 'mvn test' // Modify the test command as needed
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

        stage('Checkout Frontend code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops_front.git']])
            }
        }

        stage('Build Angular') {
            steps {
                script {
                    // Navigate to the frontend directory (if needed)
                    dir('frontend') {
                        sh 'npm version'
                        // Install Angular dependencies and build the Angular app
                        sh 'npm install'
                        sh 'npm install -g @angular/cli'
                        sh 'ng build'
                    }
                }
            }
        }

        stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml"
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}")
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path
                    artifactExists = fileExists artifactPath
                    if (artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}"
                        nexusArtifactUploader(
                            nexusVersion: 'nexus3',
                            protocol: 'http',
                            nexusUrl: 'http://192.168.33.10:8081',
                            groupId: 'pom.tn.esprit',
                            version: 'pom.1.0',
                            repository: 'maven-central-repo',
                            credentialsId: 'NEXUS_CRED',
                            artifacts: [
                                [artifactId: 'pom.DevOps_Project',
                                    classifier: '',
                                    file: artifactPath,
                                    type: pom.packaging],
                                [artifactId: 'pom.DevOps_Project',
                                    classifier: '',
                                    file: "pom.xml",
                                    type: "pom"]
                            ]
                        )
                    } else {
                        error "*** File: ${artifactPath}, could not be found"
                    }
                }
            }
        }
    }
}

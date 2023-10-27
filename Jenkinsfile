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

                                               stage("Publish to Nexus Repository Manager") {
                                                   steps {
                                                       script {
                                                           pom = readMavenPom file: "pom.xml";
                                                           filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                                                           echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                                                           artifactPath = filesByGlob[0].path;
                                                           artifactExists = fileExists artifactPath;
                                                           if(artifactExists) {
                                                               echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                                                               nexusArtifactUploader(
                                                                   nexusVersion: 'nexus3',
                                                                   protocol: 'http',
                                                                   nexusUrl: '192.168.33.10:8081',
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
                                                               );
                                                           } else {
                                                               error "*** File: ${artifactPath}, could not be found";
                                                           }
                                                       }
                                                   }
                                               }







               stage('Checkout Frontend code') {
                    steps {
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops_front.git']]])
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
                                           sh 'npm  install -g @angular/cli'
                                           sh 'ng build '
                                       }
                                   }
                               }
                           }

                           stage('Build and Push Docker Images') {
                                       steps {
                                           script {
                                               // Clone the backend repository
                                               checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops.git']])

                                               // Build the Docker image for the Spring Boot backend
                                               def backendImageTag = "Devops-project-1.0:latest"
                                               def backendDockerfile = 'Dockerfile'  // Path to Dockerfile in the backend repository
                                               sh "docker build -t ${backendImageTag} -f ${backendDockerfile} ."

                                               // Push the backend Docker image to Docker Hub
                                               withDockerRegistry([credentialsId: DOCKERHUB_CRED, url: 'https://index.docker.io/v1/']) {
                                                   sh "docker push ${backendImageTag}"
                                               }

                                               // Clean up the workspace before cloning the frontend repository
                                               deleteDir()

                                               // Clone the frontend repository
                                               checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops_front.git']])

                                               // Build the Docker image for the Angular frontend
                                               def frontendImageTag = "Devops-project-front:latest"
                                               def frontendDockerfile = 'Dockerfile'  // Path to Dockerfile in the frontend repository
                                               sh "docker build -t ${frontendImageTag} -f ${frontendDockerfile} ."

                                               // Push the frontend Docker image to Docker Hub
                                               withDockerRegistry([credentialsId: DOCKERHUB_CRED, url: 'https://index.docker.io/v1/']) {
                                                   sh "docker push ${frontendImageTag}"
                                               }
                                           }
                                       }
                                   }
                               }





    }




pipeline {
    agent any



    tools {
    nodejs 'node'
    }

      environment {
            DOCKER_IMAGE_Back_NAME = 'brain99/devops_project_back:spring'
            DOCKER_IMAGE_Front_NAME = 'brain99/devops_project_front:angular'

        }


    stages {

      






               stage('Checkout Frontend code') {
                    steps {
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops_front.git']]])
                    }
                }

                    

            

                    stage('Deploy with Docker Compose2') {
                        steps {
                            
                                // Make sure you are in the directory where the docker-compose.yml file is located

                                    sh '/usr/bin/docker-compose -f docker-compose2.yml up -d'  // Use -d to run containers in the background

                            
                        }
                    }


    }


    
    post {
        success {

             emailext subject: 'Successful Build Notification',
                body: 'The Jenkins pipeline build was successful.',
                to: 'mohamedamine.bentayaa@esprit.tn',
                from: 'mohamedamine.bentayaa@esprit.tn'
            echo 'Build successful!'
        }

        failure {

             emailext subject: 'Failed Build Notification',
                body: 'The Jenkins pipeline build failed. Please investigate.',
                to: 'mohamedamine.bentayaa@esprit.tn',
                from: 'mohamedamine.bentayaa@esprit.tn'
            echo 'Build failed. Please investigate.'
        }

    }


   }

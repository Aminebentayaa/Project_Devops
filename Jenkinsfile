pipeline {
    agent any



   

    stages {



        stage('Checkout Backend code') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/Aminebentayaa/Project_Devops.git']]])
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

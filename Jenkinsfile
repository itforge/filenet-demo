pipeline {
    agent any
    triggers {
      githubPush()
    }
    stages {
        stage('Terraform Init') {
            steps {
                echo 'Terraform Init..'
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Terraform Plan..'
                sh 'terraform plan'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

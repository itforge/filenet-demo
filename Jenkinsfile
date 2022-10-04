pipeline {
    agent any
    triggers {
      githubPush()
    }
    stages {
        stage('Terraform InitPlan') {
            steps {
                echo 'Terraform Init..'
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Terraform Plan..'
                sh 'ls'
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

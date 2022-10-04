pipeline {
    agent any
    triggers {
      githubPush()
    }
    options {
      buildDiscarder(logRotator(daysToKeepStr: "30", numToKeepStr: "100"))
      ansiColor("xterm")
    }
    stages {
        stage('Terraform Init') {
            steps {
                echo 'Terraform Init..'
                sh 'terraform init -no-color -backend-config="key=${ENV}" '
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Terraform Plan..'
                sh 'terraform plan -no-color -out myplan'
            }
        }
        stage('Terraform Apply') {
            input {
                message "Cowboy would you really like to run **${JOB_NAME}**?"
                ok "Apply ${JOB_NAME}"
            }
            steps {
                echo 'Terraform Apply..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

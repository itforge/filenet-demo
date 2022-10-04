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
                sh 'terraform init -no-color'
            }
        }
        stage('Terraform Plan') {
            steps {
                echo 'Terraform Plan..'
                sh 'terraform plan -no-color -out myplan'
            }
        }
        stage('Terraform Apply') {
            when {
              beforeInput true
            }
            input {
                message "Cowboy would you really like to run **${JOB_NAME}**"
                ok "Apply ${JOB_NAME}"
            }
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

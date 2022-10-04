pipeline {
    agent any
    triggers {
      githubPush()
    }
    options {
      buildDiscarder(logRotator(daysToKeepStr: "30", numToKeepStr: "100"))
      ansiColor("xterm")
    }
    parameters{
            choice(
                choices:['plan','apply','destroy'],
                name:'Actions',
                description: 'Describes the Actions')
            choice(
                choices:['dev','prd'],
                name:'Omgeving',
                description: 'Selecteer de omgeving')
            booleanParam(
                defaultValue: false,
                description: 'network',
                name: 'Networking'
                )
            booleanParam(
                defaultValue: false,
                description: 'compute',
                name: 'Compute')
            booleanParam(
                defaultValue: false,
                description: 'Notify',
                name: 'Notification')
    }
    stages {
        stage('Terraform Init') {
            steps {
                echo 'Terraform Init..'
                sh 'terraform init -no-color -backend-config="container_name=tfstate-${params.omgeving}" '
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
                sh 'terraform apply -no-color -input=false myplan'
            }
        }
        stage('Application Deployment') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

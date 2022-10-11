pipeline {
    agent any
    triggers {
      githubPush()
    }
    options {
      buildDiscarder(logRotator(daysToKeepStr: "30", numToKeepStr: "10"))
      ansiColor("xterm")
    }
    parameters{
            choice(
                choices:['plan','apply','destroy'],
                name:'Actions',
                description: 'Describes the Actions')
            choice(
                choices:['dev','prd'],
                name:'omgeving',
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
        stage('Tools Init') {
            steps {
                script {
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                def tfHome = tool name: 'Ansible'
                env.PATH = "${tfHome}:${env.PATH}"
                 sh 'ansible --version'
                }
        }
        stage('Terraform Init') {
            steps {
                echo 'Terraform Init..'
                sh "terraform init -no-color -backend-config=container_name=tfstate-${params.omgeving}"
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
                sh 'ansible all -m ping -i ./ansible_azure_rm.yml'
            }
        }
    }
}

pipeline {
    agent any
    triggers {
      githubPush()
    }
    options {
      buildDiscarder(logRotator(daysToKeepStr: "30", numToKeepStr: "10"))
      ansiColor("xterm")
    }
    stages {
        stage('Tools Init') {
            steps {
                script {
                    echo "PATH = ${PATH}"
                    env.PATH = "/var/lib/jenkins/.local/bin:${env.PATH}"
                    sh 'ansible --version'
                }
            }
        }    
        stage('Terraform Init') {
            steps {
                echo 'Terraform Init..'
                sh "terraform init -no-color -backend-config=container_name=tfstate-${ENVIRONMENT}"
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
                dir("ansible") {
                    sh 'ansible all -m ping -i ./ansible_azure_rm.yml'
                    sh 'ansible-playbook -i ./ansible_azure_rm.yml ./webserver.yml'
                }
            }
        }
    }
}

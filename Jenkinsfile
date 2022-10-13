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
                dir("ansible") {
                    sh 'ansible-playbook -i ./ansible_azure_rm.yml ./webserver.yml'
                }
            }
        }
        stage('Application Smoke test') {
            when { expression { false } }
            steps {
                script {
                    sh "robot --outputdir my_robot_results robot/smoketest.robot"
                    currentBuild.result = 'SUCCESS'
                }
            }
        }
    }
    post {
        always {
            script {
                step(
                [
                    $class              : 'RobotPublisher',
                    outputPath          : 'my_robot_results',
                    outputFileName      : 'output.xml',
                    reportFileName      : 'report.html',
                    logFileName         : 'log.html',
                    disableArchiveOutput: true,
                    otherFiles          : "*.png,*.jpg",
                ]
                )
            }
        }
    }
}


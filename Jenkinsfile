pipeline {
  agent any
  options {
      timeout(time: 1, unit: 'HOURS')
  }
  environment {
      DOCKER_IMAGE_NAME = "rashed86/flask_app"
  }
  stages {
    stage('Build') {
       steps {
              echo 'Running build automation'
              archiveArtifacts artifacts: 'dist/flask_app.zip'
       }
    }

    stage('Build Docker Image') {
      when {
          branch 'master'
      }
      steps {
        script {
          app = docker.build(DOCKER_IMAGE_NAME)
          app.inside {
             sh 'echo Hello, World'
          }
       }
     }
    }


   stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'rashed86') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                //input 'Deploy to Production?'
                //milestone(1)
                //implement Kubernetes deployment here
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'flask_app-kube.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}



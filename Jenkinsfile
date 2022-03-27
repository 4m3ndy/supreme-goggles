pipeline {
  agent any
  options {
      timeout(time: 30, unit: 'HOURS')
      disableConcurrentBuilds()
  }

  stages {
    stage('Pre-Build: Checkout') {
      steps{
        script {
          timeout(time: 5, unit: 'MINUTES') {
            checkout scm
          }
        }
      }
    }

    stage('Build') {
      steps {
        script {
            sh 'make build'
        }
      }
    }

    stage('Validate') {
      steps {
        script {
          sh 'make validate'
        }
      }
    }

    stage('Image Push') {
      steps {
        script {
          sh 'make push'
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          sh 'make deploy'
        }
      }
    }
  }
}
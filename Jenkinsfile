#!groovy

pipeline {
    agent { docker 'node:alpine' }

    stages {
        stage('build') {
            steps {
                sh 'npm --version'
            }
        }
    }
}
#!groovy

pipeline {
    agent {
        docker {
            image 'node'
            args '-u root:sudo
        }

    stages {
        stage('build') {
            steps {
                sh 'npm --version'
            }
        }
    }
}
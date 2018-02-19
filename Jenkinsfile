#!groovy

pipeline {
    agent {
        docker {
            image 'node'
            args '-u root:sudo'
        }
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm --version'
                sh 'npm install'
            }
        }
    }
}
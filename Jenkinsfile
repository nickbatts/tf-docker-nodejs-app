#!groovy

pipeline {
    agent { docker 'node:6.3' }
    stages {
        stage('build') {
			echo 'building...'
            steps {
                sh 'npm --version'
            }
        }
    }
}
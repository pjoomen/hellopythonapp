pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        openshiftBuild bldCfg: 'hellopythonapp', showBuildLogs: 'true'
      }
    }
    stage("test") {
      steps {
        input message: 'Approve?', id: 'approval'
      }
    }
    stage('deploy') {
      steps {
        openshiftDeploy depCfg: 'hellopythonapp'
      }
    }
  }
}

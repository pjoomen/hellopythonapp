node {
  stage('Construir y Desplegar') {
    openshiftBuild bldCfg: 'hellopythonapp',
      namespace: 'development00',
      showBuildLogs: 'true'
    openshiftVerifyDeployment depCfg: 'hellopythonapp',
      namespace: 'development00'
  }
  stage('Aprobar (Pruebas)') {
    input message: 'Aprobado para Pruebas?',
      id: 'approval'
  }
  stage('Desplegar en Pruebas') {
    openshiftTag srcStream: 'hellopythonapp',
      namespace: 'development00',
      srcTag: 'latest',
      destinationNamespace: 'testing00',
      destStream: 'hellopythonapp',
      destTag: 'test'
    openshiftVerifyDeployment depCfg: 'hellopythonapp',
      namespace: 'testing00'
  }
  stage('Aprobar (Produccion)') {
    input message: 'Aprobado para Produccion?',
      id: 'approval'
  }
  stage('Desplegar en Produccion') {
    openshiftTag srcStream: 'hellopythonapp',
      namespace: 'development00',
      srcTag: 'latest',
      destinationNamespace: 'production00',
      destStream: 'hellopythonapp',
      destTag: 'prod'
    openshiftVerifyDeployment depCfg: 'hellopythonapp',
      namespace: 'production00'
  }
}

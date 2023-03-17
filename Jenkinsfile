@Library(['piper-lib-os']) _
pipeline {
  agent any
  options {
    disableConcurrentBuilds()
  }
  stages {
    
   
    stage('gCTS Deploy') {
      when {
        anyOf {
          branch 'main'
        }
      }
      
      steps {
        gctsDeploy(
          script: this
          )
      }
    }
    
    
      stage('build') {
      when {
        anyOf {
          branch 'main'
        }
      }
      
      steps {
        buildExecute(
          script: this
          )
      }
    }
    
    stage('gctsExecuteABAPQualityChecks') {
      when {
        anyOf {
          branch 'main'
        }
      }
      steps {
        script {
          try {
          gctsExecuteABAPQualityChecks(
          script: this,
          host: HOST,
          client: CLIENT,
          abapCredentialsId: DEMOCREDS,
          repository: REPO,
          verbose: true,
          scope: 'localChangedObjects',
          commit: "${env.GIT_COMMIT}",
          workspace: "${WORKSPACE}")
        } catch (Exception ex) {
          currentBuild.result = 'FAILURE'
          unstable(message: "${STAGE_NAME} is unstable")
        }

      }
    }
  }

stage('Results in Checkstyle') {
  when {
      anyOf {
        branch 'main'
      }
    }
  steps{

     recordIssues(
          enabledForFailure: true, aggregatingResults: true,
          tools: [checkStyle(pattern: 'ATCResults.xml', reportEncoding: 'UTF8'),checkStyle(pattern: 'AUnitResults.xml', reportEncoding: 'UTF8')]
       )

      }
    }
stage('Rollback') {
            when {
              expression {
                currentBuild.result == 'FAILURE'
              }
            }
            steps {
              gctsRollback(
                script: this,
                host: HOST,
                client: CLIENT,
                abapCredentialsId: DEMOCREDS,
                repository: REPO
          )

      }
    }
  }
 
}

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
          branch 'gCTS'
        }
      }
      steps {
        gctsDeploy(
          script:this,
          skipSSLVerification:true,
          verbose:true)
      }
    }
    
    stage('gctsExecuteABAPQualityChecks') {
      when {
        anyOf {
          branch 'gCTS'
        }
      }
      steps {
        script {
          try {
          gctsExecuteABAPQualityChecks(
          script:this,
          host:HOST,
          client:CLIENT,
          verbose:true,
          abapCredentialsId:DEMOCREDS,
          repository:REPO,
          skipSSLVerification:true,
          scope:'localChangedPackages',
          commit:"${env.GIT_COMMIT}",
          workspace:"${WORKSPACE}")
        } catch (Exception ex) {
          currentBuild.result = 'FAILURE'
          unstable(message:"${STAGE_NAME} is unstable")
        }

      }
    }
  }

stage('Results in Checkstyle') {
  when {
      anyOf {
        branch 'gCTS'
      }
    }
  steps{

     recordIssues(
          enabledForFailure:true, aggregatingResults:true,
          tools:[checkStyle (pattern:'ATCResults.xml', reportEncoding:'UTF8'), checkStyle (pattern:'AUnitResults.xml', reportEncoding:'UTF8')]
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
                script:this,
                host:HOST,
                client:CLIENT,
                skipSSLVerification:true,
                abapCredentialsId:DEMOCREDS,
                repository:REPO
          )

      }
    }
  }

}

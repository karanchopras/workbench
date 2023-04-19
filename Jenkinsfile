@Library(['piper-lib-os']) _
pipeline {
  agent any
  options {
    disableConcurrentBuilds()
  }

  environment {
    DEMOCREDS= 'ABAP_SP2'
    HOST= 'https://sapsp2.camelot-idpro.de:44300'
    CLIENT= '100'
    REPO= 'karanchopras-workbench'
    REPO_URL= "https://github.com/karanchopras/workbench"
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
          host:HOST,
          client:CLIENT,
          abapCredentialsId:DEMOCREDS,
          repository:REPO,
          skipSSLVerification:true,
          remoteRepositoryURL:REPO_URL,
          verbose:true,
          role:'SOURCE',
          vSID:'GIT')
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
                abapCredentialsId:DEMOCREDS,
                repository:REPO
          )

      }
    }
  }

}

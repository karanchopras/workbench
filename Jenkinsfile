@Library(['piper-lib-os']) _
pipeline {
  agent any
  options {
    disableConcurrentBuilds()
  }

  environment {
    DEMOCREDS = 'ABAPUserPasswordCredentialsId'
    HOST = 'https://saps4s.camelot-idpro.de:44300'
    CLIENT = '100'
    REPO = 'workbench'
    REPO_URL = "https://github.com/karanchopras/workbench.git"
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
          script: this,
          host: HOST,
          client: CLIENT,
          abapCredentialsId: DEMOCREDS,
          repository: REPO,
          remoteRepositoryURL: REPO_URL,
          role: 'SOURCE',
          vSID: 'GIT')

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


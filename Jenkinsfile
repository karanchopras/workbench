@Library(['piper-lib-os']) _
<<<<<<< HEAD
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
=======
pipeline{
        agent any
      options {
        disableConcurrentBuilds()
>>>>>>> 84859b68f873aa21bf3abe22f608d5b198650162
        }
<<<<<<< HEAD
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
=======
        stages {
                stage('prepare') {
                when { anyOf { branch 'main' } }
                        steps {
                                checkout scm
                                setupCommonPipelineEnvironment script : this
                        }
                }
                stage('Deploy') {
                        when { anyOf { branch 'main' } }
                        steps {
                                gctsDeploy script: this

                        }
                }
>>>>>>> 84859b68f873aa21bf3abe22f608d5b198650162
        }
<<<<<<< HEAD
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

=======
>>>>>>> 84859b68f873aa21bf3abe22f608d5b198650162
}

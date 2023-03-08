@Library(['piper-lib']) _
pipeline{
agent any
options {
disableConcurrentBuilds()
}
stages {
stage('prepare') {
when { anyOf { branch 'main' } }
steps {
checkout scm
setupCommonPipelineEnvironment script:this
}
}
stage('Deploy') {
when { anyOf { branch 'main' } }
steps {
gctsDeploy(
script : this
)
}
}
}
}

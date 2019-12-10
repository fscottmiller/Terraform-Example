@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('tf plan') {
		withCredentials([string(credentialsId: 'gcp', variable: 'gcp')]) {
			sh "set TF_VAR_project=ordinal-motif-254101"
			sh "set TF_VAR_creds=${gcp}"
			terraform 'init'
			echo "${terraform 'plan'}"
		}
	}
}

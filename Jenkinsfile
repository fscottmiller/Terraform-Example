@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('tf plan') {
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			sh "set TF_VAR_project=ordinal-motif-254101"
			echo "${gcp}"
			sh "set TF_VAR_creds='${gcp}'"
			terraform 'init'
			echo "${terraform 'plan'}"
		}
	}
}

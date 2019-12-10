@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('tf plan') {
		sh 'set TF_VAR_project=ordinal-motif-254101'
		echo "${terraform 'plan'}"
	}
}

@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('tf plan') {
		sh "env"
		git url: "https://github.com/fscottmiller/Terraform-Example"
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			sh "set TF_VAR_project=ordinal-motif-254101"
			echo "${gcp}"
			sh "set TF_VAR_creds='${gcp}'"
			echo "${terraform 'init'}"
			def plan = terraform 'plan'
			input "${plan}"
		}
	}
}

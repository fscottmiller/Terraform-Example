@Library('jenkins-ext@master') _
import groovy.json.JsonOutput

require 'terraform'
initialize this

kubepipe {
	stage('tf plan') {
		git url: "https://github.com/fscottmiller/Terraform-Example"
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			sh "set TF_VAR_project=ordinal-motif-254101"
			sh "set TF_VAR_creds='${gcp}'"
			terraform 'init'
			terraform 'plan -out=myplan'
			def plan = "<html><body><p>${JsonOutput.prettyPrint(terraform('show -json myplan'))}</p></body></html>"
			writeFile file: "index.html", text: plan
		}
	}
	stage('confirm') {
		// archive (includes: 'pkg/*.gem')
		publishHTML (target: [
			allowMissing: false,
			alwaysLinkToLastBuild: false,
			keepAll: true,
			reportDir: '',
			reportFiles: 'index.html',
			reportName: "Plan"
		])
	}
}

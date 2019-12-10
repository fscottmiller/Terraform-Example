@Library('jenkins-ext@master') _
import groovy.json.JsonOutput

def jsonToHtml(json, text="") {
	if (text == "") {
		text = "<html><body><p>"
	}
	echo "${json.getClass()}"
	// switch(json.getClass()) {
	// 	case ''
	// }
}

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
			def plan = terraform 'show -json myplan'
			def html = jsonToHtml(readJSON(text: plan))
			writeFile file: "index.html", text: html
			sh 'cat index.html'
		}
	}
	stage('confirm') {
		sh 'cat index.html'
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

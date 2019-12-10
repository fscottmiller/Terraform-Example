@Library('jenkins-ext@master') _

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
			writeFile file: "index.html", text: "<html><body>${plan}</body></html>"
		}
	}
	stage('report') {
		publishHTML (target: [
			allowMissing: false,
			alwaysLinkToLastBuild: false,
			keepAll: true,
			reportDir: '',
			reportFiles: 'index.html',
			reportName: "Plan"
		])
	}
	stage('confirm') {
		input "Do you want to continue?\nView your planned infrastucture: ${JENKINS_URL}${BUILD_URL.split('8080/')[1]}Plan"
	}
}

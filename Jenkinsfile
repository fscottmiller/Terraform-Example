@Library('jenkins-ext@addShellLabels') _

require 'terraform'
initialize this

kubepipe {
	stage('Plan') {
		git url: "https://github.com/fscottmiller/Terraform-Example"
		sh "set TF_VAR_project=ordinal-motif-254101"
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			sh "set TF_VAR_creds='${gcp}'"
		}
		terraform 'init'
		terraform 'plan -out=myplan'
		def plan = terraform 'show -json myplan'
		writeFile file: "index.html", text: "<html><body>${plan}</body></html>"
		publishHTML (target: [
			allowMissing: false,
			alwaysLinkToLastBuild: false,
			keepAll: true,
			reportDir: '',
			reportFiles: 'index.html',
			reportName: "Plan"
		])
	}
	stage('Apply') {
		input "Do you want to continue?\nView your planned infrastucture: ${BUILD_URL}Plan"
		terraform 'apply -auto-approve myplan'
	}
	stage('Destroy') {
		input 'Destroy now?'
		terraform 'destroy -auto-approve'
	}
}

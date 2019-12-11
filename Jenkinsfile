@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('Plan') {x
		git url: "https://github.com/fscottmiller/Terraform-Example"
		def plan
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			withEnv(["TF_VAR_project=ordinal-motif-254101", "TF_VAR_creds=${gcp}", "TF_VAR_backendCreds=${gcp}"]) {
				terraform "init -backend-config 'credentials=${gcp}'"
				terraform 'plan -out=myplan'
				plan = readJSON text: terraform('show -json myplan')
			}
		}
		plan['variables'].remove('creds')
		writeJSON file: 'index.html', json: plan, pretty: 4
		def html = "<pre>${readFile file: 'index.html'}</pre>"
		writeFile file: 'index.html', text: html
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
		input "Do you want to continue?\nView your planned infrastucture:\n${BUILD_URL}Plan"
		terraform 'apply -auto-approve myplan'
	}
	stage('Destroy') {
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			withEnv(["TF_VAR_project=ordinal-motif-254101", "TF_VAR_creds=${readFile file: gcp}", "TF_VAR_backendCreds=${gcp}"]) {
				input 'Destroy now?'
				terraform 'destroy -auto-approve'
			}
		}
	}
}

@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('Plan') {
		git url: "https://github.com/fscottmiller/Terraform-Example"
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			withEnv(["TF_VAR_project=ordinal-motif-254101", "TF_VAR_creds=${readFile file: gcp}"]) {
				terraform 'init'
				terraform 'plan -out=myplan'
			}
		}
		def plan = readJSON text: terraform('show -json myplan')
		plan['variables'].remove('creds')
		writeJSON file: 'index.html', json: plan, pretty: 4
		def html = "<pre>${readFile file: 'index.html'}</pre>"
		writeFile file: 'index.html', text: html
		// def html = "<html><body>${readFile file: 'index.html'}</body></html>"
		// // html = html.replace("\n","<br>")
		// def parsing = html.split("\n")
		// def tabCount = 0
		// parsing.each {
		// 	it = "  "*tabCount + parsing
		// 	if (parsing.contains("{")) {
		// 		tabCount += 1
		// 	}
		// 	if (parsing.contains("}")) {
		// 		tabCount -= 1
		// 	}
		// }
		// writeFile file: 'index.html', text: parsing.join("<br>")
		// writeFile file: "index.html", text: "<html><body>${plan.replace('\\n','<br>').replace('\\"','\"')}</body></html>"
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
		input "Do you want to continue? View your planned infrastucture:\n${BUILD_URL}Plan"
		terraform 'apply -auto-approve myplan'
	}
	stage('Destroy') {
		withCredentials([file(credentialsId: 'gcp', variable: 'gcp')]) {
			withEnv(["TF_VAR_project=ordinal-motif-254101", "TF_VAR_creds=${readFile file: gcp}"]) {
				input 'Destroy now?'
				terraform 'destroy -auto-approve'
			}
		}
	}
}

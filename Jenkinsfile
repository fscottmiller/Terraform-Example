@Library('jenkins-ext@master') _
import groovy.json.JsonOutput

def jsonToHtml(json) {
	def html = """
<html>
	<body>
		<div id='test'></div>
		<script type='text/javascript' src='https://raw.githubusercontent.com/caldwell/renderjson/master/renderjson.js'>
		<script>
			document.getElementById("test").appendChild(
				renderjson(${json})
			);
		</script>
	</body>
</html>
"""
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
			def plan = terraform('show -json myplan')
			def html = jsonToHtml(readJson(text: plan))
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

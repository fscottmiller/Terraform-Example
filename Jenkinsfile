@Library('jenkins-ext@master') _

require 'terraform'
initialize this

kubepipe {
	stage('get tf version') {
		echo "${terraform '--version'}"
	}
}

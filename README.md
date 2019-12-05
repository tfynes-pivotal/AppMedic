# AppMedic

"BUILDPACK'LESS" packaging for Application SideCar web-shell (pcfshell_debugger_buildpack) on Cloud Foundry

Sample "AppMedicTest" spring-boot application presenting simple hello-world rest service hosted on cloud foundry with secondary exposed route to sidecar deployed shellinabox daemon allowing for web-shell access to the live container

Useful for advanced troubleshooting / debugging of an application running in cloud foundry

Repo uses the 'offline buildpack' package from https://github.com/tfynes-pivotal/pcfshell_debugger_buildpack
which comprises of shellinabox daemon and haproxy facade for basic-auth


How to add AppMedic web-shell to spring boot application:

	copy 'pcfshell_debugger_buildpack_offline.zip' and 'extract_launch_debugger.sh' to your <app>/src/main/resources/static folder

	package your application for deployment to cloud foundry (e.g. mvn package)

	'manifest.yml' defines app manifest with sidecar definition

	'deploy_with_debugger.sh' script illustates commands to push application with sidecar

	'addAppDebuggerRoute.sh' script uses the 'cf curl' command to add an additional port to an appliation and an additional route to expose it externally


	
	addAppDebuggerRoute.sh AppName AppDebuggerHostname CloudFoundrySpace CloudFoundryRouteDomain



Note 'deploy_with_debugger.sh' illustates how the v3 api is needed to push an app to cloud foundry that uses a sidecar
cf v3-create-app
cf v3-apply-manifest
cf v3-push

Then the 'addAppDebuggerRoute.sh' script is used to expose the secondard port/route and restage the app.



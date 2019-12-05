#!/bin/bash
cf v3-create-app appmedictest
cf v3-apply-manifest -f ./manifest.yml
cf v3-push appmedictest -p ./target/AppMedic-0.0.1-SNAPSHOT.jar
./addAppDebuggerRoute.sh appmedictest appmedictestdebugger DemoSpace homelab.fynesy.com

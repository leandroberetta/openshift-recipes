
oc new-build https://github.com/leandroberetta/openshift-recipes.git --context-dir=builds/chained-builds/app-build --name=app-build --strategy=docker

oc create -f ./app-runtime/app-runtime-bc.yaml

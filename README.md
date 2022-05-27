# Knative on KinD
This is a very simple script that setup knative on KinD based on the blog post at: 
[https://knative.dev/blog/articles/set-up-a-local-knative-environment-with-kind/](https://knative.dev/blog/articles/set-up-a-local-knative-environment-with-kind/)

# Usage
Run the following command to set up your brand new Knative environment (Both serving and eventing)
```shell
./setup.sh
```
To clean it up
```shell
./teardown.sh
```

# Prerequisite
This script assumes that docker and [KinD](https://kind.sigs.k8s.io/docs/user/quick-start#installation) are already installed

# Versions
* Kubernetes - 1.24.0
* Knative - v1.4.0
* Knative Net Kourier - v1.4.0

# How to upgrade versions
To upgrade the Kubernetes version look up the latest version at [https://github.com/kubernetes-sigs/kind/releases](https://github.com/kubernetes-sigs/kind/releases) 
and update the image tag value in "clusterconfig.yaml" file.

To upgrade Kantive and Knative Net Kourier respectively go to [https://github.com/knative/serving/releases](https://github.com/knative/serving/releases) 
and [https://github.com/knative-sandbox/net-kourier/releases](https://github.com/knative-sandbox/net-kourier/releases)
download "serving-core.yaml", "serving-crds.yaml", "eventing-crds.yaml", "eventing-core.yaml", "in-memory-channel.yaml", and "mt-channel-broker.yaml" from [https://github.com/knative/serving/releases](https://github.com/knative/serving/releases) 
and "kourier.yaml" from  [https://github.com/knative-sandbox/net-kourier/releases](https://github.com/knative-sandbox/net-kourier/releases)
and update these file in the project. 
(please notice that you need to edit and add "nodePort: 31080" and "nodePort: 31443" to "kourier.yaml" file see the original blog post)



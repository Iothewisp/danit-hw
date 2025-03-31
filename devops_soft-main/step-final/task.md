1. Create GitHub repo with:
 - test python backend server. Just script which listening on some port and respond 200 on /
 - Dockerfile with everything needed to run this script
 - GitHub action which will build docker image automatically and push to docker hub. Use Github secrets to store your docker hub creds
2. Use terraform code to create EKS cluster (https://gitlab.com/dan-it/groups/devops_soft/-/tree/main/step-final/EKS?ref_type=heads)
 - one node group with one node
 - nginx ingress controller
3. Write terraform code which will install ArgoCD to EKS using helm chart or raw k8s manifest
 - argocd must have dns name in domain: devops1.test-danit.com (change devops1 to your group number) example: argocd.student1.devops1.test-danit.com where student1 is your cluster name.
4. Write K8S manifests to deploy your app from item 1 to EKS.
 - deployment, service, ingress.
 - app must be available by dns name in domain: devops1.test-danit.com (change devops1 to your group number) example: app.student1.devops1.test-danit.com
5. Write ArgoCD app which will deliver code from item 4 to EKS and will update it on new commit.


# Stackrox Demo

Create secrets.yaml and review it.

```sh
cp ansible/group_vars/all/secrets.yaml.sample ansible/group_vars/all/secrets.yaml
```

Install the pre-requisites.

```sh
ansible-galaxy collection install kubernetes.core
sudo dnf install python3-openshift
```

Patch the existing roles.

```sh
echo -n > ansible/roles/ocp4_workload_stackrox_demo_apps/tasks/pre_workload.yml
echo -n > ansible/roles/ocp4_workload_stackrox_demo_pipeline/tasks/pre_workload.yml
```

Deploy the demo.

```sh
cd ansible
export K8S_AUTH_VERIFY_SSL=false
export K8S_AUTH_KUBECONFIG="$KUBECONFIG"
ansible-playbook install.yaml
```


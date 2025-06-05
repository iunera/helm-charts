# NLWeb Helm Chart

A Helm chart for deploying the NLWeb application on Kubernetes. This chart provides a flexible and configurable deployment solution with support for various Kubernetes features.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure (if persistence is needed)

## Installation

### Quick Start

```bash
# Add the iunera Helm repository
helm repo add iunera https://iunera.github.io/helm-charts/

# Update your Helm repositories
helm repo update

# Install the chart with the release name "my-release"
helm install my-release iunera/nlweb

# Alternatively, install from local directory
helm install my-release ./chart/nlweb
```

### Using Custom Configuration

```bash
# Install with custom values file
helm install my-release iunera/nlweb --values custom-values.yaml
```

## Configuration

The following table lists the configurable parameters of the NLWeb chart and their default values.

| Parameter                          | Description                                                  | Default                           |
|------------------------------------|--------------------------------------------------------------|-----------------------------------|
| `replicaCount`                     | Number of replicas                                           | `1`                               |
| `image.repository`                 | Image repository                                             | `repository/nlweb`                |
| `image.tag`                        | Image tag                                                    | `latest`                          |
| `image.pullPolicy`                 | Image pull policy                                            | `IfNotPresent`                    |
| `service.type`                     | Kubernetes Service type                                      | `ClusterIP`                       |
| `service.port`                     | Service port                                                 | `8000`                            |
| `ingress.enabled`                  | Enable ingress controller resource                           | `false`                           |
| `volumes.enabled`                  | Enable persistent volumes                                    | `true`                            |
| `volumes.pvc.enabled`              | Enable PVC                                                   | `false`                           |
| `resources`                        | CPU/Memory resource requests/limits                          | `{}`                              |

### Example Values File

Below is an example of a values file that can be used for customization:

```yaml
image:
  repository: repository/nlweb
  tag: latest
  pullPolicy: Always

env:
  - name: AZURE_VECTOR_SEARCH_ENDPOINT
    value: "https://your-search-endpoint.search.windows.net"
  - name: NLWEB_LOGGING_PROFILE
    value: production

# For sensitive values, use Kubernetes secrets instead of hardcoding
# envFrom:
#   - secretRef:
#       name: nlweb-secrets

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
  hosts:
    - host: your-domain.example.com
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls:
    - secretName: your-domain-tls
      hosts:
        - your-domain.example.com
```

## Features

This Helm chart provides the following features:

* **Health Monitoring**: Default health endpoint at `/` for `livenessProbe` and `readinessProbe`
* **Environment Configuration**: Support for both `env:` and `envFrom:` settings
* **Network Configuration**: Support for `hostAliases` for legacy applications
* **Application Arguments**: Support for `extraArgs` to pass parameters to the application
* **Storage Options**:
  * Support for PVC templates and existing PVCs
  * Support for ConfigMaps and existing ConfigMaps
  * Support for mounting secrets as volumes
* **Security**:
  * Principles of least privilege with securityContext
  * Capability dropping with `Drop: ALL`
  * Read-only root filesystem with `readOnlyRootFilesystem: true`
  * Non-root user execution with `uid/gid: 999` by default
* **Temporary Storage**: `emptyDir` volumes for `/tmp` and `/data` by default

## Troubleshooting

If you encounter issues with your deployment, check the following:

1. Verify that all required environment variables are set
2. Check pod logs for application errors
3. Ensure that your Kubernetes cluster meets the prerequisites
4. Verify that any referenced secrets or ConfigMaps exist in the namespace

## Contributing

This chart is maintained in the [iunera/helm-charts](https://github.com/iunera/helm-charts) repository. To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

### Publishing the Chart

The chart is automatically published to the [iunera Helm repository](https://iunera.github.io/helm-charts/) when changes are merged to the main branch. The process typically involves:

1. Updating the chart version in `Chart.yaml`
2. Packaging the chart with `helm package chart/nlweb`
3. Updating the repository index with `helm repo index`
4. Publishing the updated index and packaged chart to GitHub Pages

## Related Projects

NLWeb is part of a larger ecosystem of tools and libraries:

* [NLWeb](https://github.com/iunera/NLWeb) - The main NLWeb application repository
* [nlweb-js-client](https://github.com/iunera/nlweb-js-client) - JavaScript client for NLWeb
* [json-ld-markdown](https://github.com/iunera/json-ld-markdown) - JSON-LD utilities for Markdown
* [jsonld-schemaorg-javatypes](https://github.com/iunera/jsonld-schemaorg-javatypes) - Java types for Schema.org JSON-LD
* [Docker Hub](https://hub.docker.com/r/iunera/nlweb) - Official Docker images for NLWeb

## Further Reading

* [Enterprise Data with Java, Spring AI & NLWeb](https://www.iunera.com/kraken/machine-learning-ai/enterprise-data-java-spring-ai-nlweb/) - Article on using NLWeb with Spring AI for enterprise data applications

## Credits

This Helm chart is based on the [helm-microservice](https://github.com/cetic/helm-microservice/tree/master/templates) template.

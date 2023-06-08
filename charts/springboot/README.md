# Springboot helm chart
The springboot helmchart is our helmchart we use for mostly every of our springboot based microservices, exposed by ClusterIPs and Ingress Controllers. It's require Kubernetes 1.23 upwards 

## Installation

````
helm install my-release iunera/springboot --values values.yaml
````

## Values override

We override the values during deployment (via Flux Gitops) with values like in the following example.

````
extraArgs:
  - --spring.application.name=iu-gtfs-rest-dev

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    kubernetes.io/tls-acme: "true"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/enable-modsecurity: "true"
    nginx.ingress.kubernetes.io/enable-owasp-core-rules: "true"

  hosts:
    - host: springboot.k8s.iunera.com
      paths:
        - path: /apiv1
          pathType: ImplementationSpecific
        - path: /swagger-ui
          pathType: ImplementationSpecific

    - host: v1.springboot.k8s.iunera.com
      paths:
        - path: /apiv1
          pathType: ImplementationSpecific
        - path: /swagger-ui
          pathType: ImplementationSpecific
  tls:
    - secretName: springboot.k8s.iunera.com-tls
      hosts:
        - springboot.k8s.iunera.com
        - v1.springboot.k8s.iunera.com
````


## Features
Features are: 
* Default actuator endpoints to `/actuator/health` for `livenessProbe` and `readinessProbe`
* support plain `env:` and `envFrom:` Settings
* support `hostAliases` for legacy Applications
* support `extraArgs` for parameters in spring-boot
* support PVC Templates and existing PVCs
* support configMaps and existingConfigMaps
* support mounting secrets as volumes for jaas-configs, keystores.jks or ssh keys etc.
* resource limits per default: `cpu: 500m` / `memory: 256Mi` / `ephemeral-storage: "4Gi"`
* default prometheus scrape metrics with port `8080` and `/actuator/prometheus`
* Principles of least privilege: securityContext with `Drop: ALL`, `readOnlyRootFilesystem` and force to `uid/gid: 1000` by default 
* `emptyDir /tmp` by default


## TODOs

````
Nodeport / ClusterIP support beispiel hier https://github.com/cetic/helm-microservice/tree/master/templates

https://github.com/hazelcast/charts/blob/master/stable/hazelcast-enterprise/values.yaml

https://github.com/cetic/helm-microservice/tree/master/templates

initContainer: ??

````
# iunera helm charts
A bunch of helm-charts we need to deploy our services and components. And some of them we just forked and modified to our needs. 
code on github: https://github.com/iunera/helm-charts

## Repo Installation
````
helm repo add iunera https://iunera.github.io/helm-charts
````

# More
Visit our website:
https://www.iunera.com


## Spring-boot helm chart
The springboot helmchart is our helmchart we use for mostly every of our springboot based microservices, exposed by ClusterIPs and Ingress Controllers. It's require Kubernetes 1.23 upwards 

We override the values during deployment (via Flux Gitops) with values like in the following example.

````
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
          - "/apiv1"
          - "/swagger-ui"
          - "/v3"
      - host: v1.springboot.k8s.iunera.com
        paths:
          - "/apiv1"
          - "/swagger-ui"
          - "/v3"
    tls:
      - secretName: springboot.k8s.iunera.com-tls
        hosts:
          - springboot.k8s.iunera.com
          - v1.springboot.k8s.iunera.com
````


````
helm install my-release iunera/springboot --values values.yaml
````

Features are: 
* Default actuator endpoints to `/actuator/health` for `livenessProbe` and `readinessProbe`
* support `hostAliases` for legacy Applications
* support `extraArgs` for parameters in spring-boot
* support persistence/pvc and 
* support configMaps and existingConfigMaps
* support mounting secrets as Volumes for jaas configs, keystores.jks or ssh keys etc.
* resource limits per default: cpu: 200m / memory: 256Mi


## TODO 

````

env support
env support from configmaps
env support from secrets
- name: POSTGRES_REPLICATION_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ template "postgresql.secretName" . }}


Nodeport / ClusterIP support beispiel hier https://github.com/cetic/helm-microservice/tree/master/templates



https://github.com/hazelcast/charts/blob/master/stable/hazelcast-enterprise/values.yaml

https://github.com/cetic/helm-microservice/tree/master/templates

````
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
* add `extraArgs` for parameters in spring-boot

## TODO 

````

env support

Nodeport / ClusterIP support beispiel hier https://github.com/cetic/helm-microservice/tree/master/templates


configmal support?


secrets support 




            - name: POSTGRES_REPLICATION_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ template "postgresql.secretName" . }}


persistence

https://github.com/hazelcast/charts/blob/master/stable/hazelcast-enterprise/values.yaml


````

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

````
helm install my-release cetic/microservice
````

## TODO 

````

hostalias

{{ .Values.livenessProbePath }}

extraArgs

configmal support?


secrets support 


env support


            - name: POSTGRES_REPLICATION_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ template "postgresql.secretName" . }}


persistence

https://github.com/hazelcast/charts/blob/master/stable/hazelcast-enterprise/values.yaml


````

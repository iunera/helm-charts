# iunera Wordpress chart

```
helm dependency update ./wordpress/
helm -n dev upgrade --install devwp ./wordpress --dry-run --values testvalues.yaml
```

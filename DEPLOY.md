# Swiss Job Hunter Container + k3s/Flux

Empfohlenes Ziel-Image:

`git.foobar.vip:5050/alex/swiss-job-hunter:0.1.0`

Build und Push:

```bash
docker build -t git.foobar.vip:5050/alex/swiss-job-hunter:0.1.0 .
docker push git.foobar.vip:5050/alex/swiss-job-hunter:0.1.0
```

Das Flux-Repo referenziert dieses Image bereits.

Im Kubernetes-Deployment werden die Variablen nicht ueber eine gemountete `.env`
gesetzt, sondern ueber `ConfigMap` + `Secret`. Die Namen entsprechen 1:1 den
Eintraegen aus `.env.example`.

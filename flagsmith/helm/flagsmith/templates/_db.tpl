{{- define "db" }}
- name: DATABASE_USER
  valueFrom:
    secretKeyRef:
      name: flagsmith.torus-flagsmith.credentials.postgresql.acid.zalan.do
      key: username
- name: DATABASE_PASSWORD
  valueFrom:
    secretKeyRef:
      name: flagsmith.torus-flagsmith.credentials.postgresql.acid.zalan.do
      key: password
- name: DATABASE_URL
  value: "{{ printf "postgres://${DATABASE_USER}:${DATABASE_PASSWORD}@torus-flagsmith:5432/flagsmith-db" }}"
{{- end -}}

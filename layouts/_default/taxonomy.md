# {{ .Title }}

{{ range .Pages }}
- [{{ .Title }}]({{ .Permalink }})
{{ end }}
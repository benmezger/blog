+++
title = "Export org-roam backlinks with Gohugo"
author = ["Ben Mezger"]
date = 2021-03-07T14:40:00-03:00
slug = "export_org_roam_backlinks_with_gohugo"
tags = ["emacs", "orgroam", "orgmode"]
type = "notes"
draft = false
bookCollapseSection = true
+++

tags
: [Org-mode]({{<relref "2020-06-04--11-35-15Z--org_mode.md#" >}}) [Emacs]({{<relref "2020-06-04--11-36-43Z--emacs.md#" >}}) [Org-roam]({{<relref "2020-06-04--11-51-18Z--org_roam.md#" >}})

Since [Org-roam export backlinks on Hugo]({{<relref "2020-06-04--11-29-02Z--org_roam_export_backlinks_on_hugo.md#" >}}) no longer works, I found a solution
to handle backlinks in Hugo itself.

The following Hugo [partial template](https://gohugo.io/templates/partials/) will add backlinks to a note if any.

```text
{{ $re := $.File.BaseFileName }}
{{ $backlinks := slice }}
{{ range .Site.AllPages }}
   {{ if and (findRE $re .RawContent) (not (eq $re .File.BaseFileName)) }}
      {{ $backlinks = $backlinks | append . }}
   {{ end }}
{{ end }}

<hr>
{{ if gt (len $backlinks) 0 }}
  <div class="bl-section">
    <h4>Links to this note</h4>
    <div class="backlinks">
      <ul>
       {{ range $backlinks }}
          <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
       {{ end }}
     </ul>
    </div>
  </div>
{{ else  }}
  <div class="bl-section">
    <h4>No notes link to this note</h4>
  </div>
{{ end }}
```

Then, include the previous partial to your [`single.html`](https://gohugo.io/templates/single-page-templates/#postssinglehtml). For example, this page
is created with a `single.html` template, with the following content:

```text
{{ define "main" }}
<article class="markdown">
  <h1>
    <a href="{{ .RelPermalink }}">{{ .Title }}</a>
  </h1>
  {{ partial "docs/post-meta" . }}
  <p>
    {{- .Content -}}
  </p>
  {{ partial "docs/backlinks" . }}
</article>
{{ end }}

{{ define "toc" }}
  {{ partial "docs/toc" . }}
{{ end }}
```
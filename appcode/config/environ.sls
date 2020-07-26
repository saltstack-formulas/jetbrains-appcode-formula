# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode as a with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{%- set sls_package_install = tplroot ~ '.macapp.install' %}

include:
  - {{ sls_package_install }}

a-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ a.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='a-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 644
    - user: {{ a.identity.rootuser }}
    - group: {{ a.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      path: {{ a.config.path }}/{{ a.pkg.name }}{{ '' if 'edition' not in a else ' %sE'|format(a.edition) }}.app/Contents/MacOS   # noqa 204
      environ: {{ a.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

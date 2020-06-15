# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{%- set sls_package_install = tplroot ~ '.macapp.install' %}

include:
  - {{ sls_package_install }}

appcode-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ appcode.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='appcode-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 644
    - user: {{ appcode.identity.rootuser }}
    - group: {{ appcode.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        path: '/Applications/{{ appcode.pkg.name }}{{ '' if 'edition' not in appcode else '\ %sE'|format(appcode.edition) }}.app/Contents/MacOS'    # noqa 204
        environ: {{ appcode.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

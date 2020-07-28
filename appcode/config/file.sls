# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if 'config' in appcode and appcode.config and appcode.config_file %}
           {%- set sls_package_install = tplroot ~ '.macapp.install' %}

include:
  - {{ sls_package_install }}

appcode-config-file-managed-config_file:
  file.managed:
    - name: {{ appcode.config_file }}
    - source: {{ files_switch(['file.default.jinja'],
                              lookup='appcode-config-file-file-managed-config_file'
                 )
              }}
    - mode: 640
    - user: {{ appcode.identity.rootuser }}
    - group: {{ appcode.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
      config: {{ appcode.config|json }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}

# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}
{%- set sls_package_clean = tplroot ~ '.macapp.clean' %}

include:
  - {{ sls_package_clean }}

appcode-config-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_list_item
               {%- if appcode.config_file and appcode.config %}
      - {{ appcode.config_file }}
               {%- endif %}
               {%- if appcode.environ_file %}
      - {{ appcode.environ_file }}
               {%- endif %}
      - {{ appcode.dir.homes }}/{{ appcode.identity.user }}/Desktop/{{ appcode.pkg.name }}*{{ appcode.edition }}*
    - require:
      - sls: {{ sls_package_clean }}

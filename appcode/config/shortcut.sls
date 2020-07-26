# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- if appcode.linux.install_desktop_file %}
    {%- if appcode.pkg.use_upstream_macapp %}
        {%- set sls_package_install = tplroot ~ '.macapp.install' %}
    {%- else %}
        {%- set sls_package_install = tplroot ~ '.archive.install' %}
    {%- endif %}

include:
  - {{ sls_package_install }}

appcode-config-file-file-managed-desktop-shortcut_file:
  file.managed:
    - name: {{ appcode.linux.desktop_file }}
    - source: {{ files_switch(['shortcut.desktop.jinja'],
                              lookup='appcode-config-file-file-managed-desktop-shortcut_file'
                 )
              }}
    - mode: 644
    - user: {{ appcode.identity.user }}
    - makedirs: True
    - template: jinja
    - context:
      command: {{ appcode.command|json }}
                      {%- if grains.os == 'MacOS' %}
      edition: {{ '' if 'edition' not in appcode else appcode.edition|json }}
      appname: {{ appcode.dir.path }}/{{ appcode.pkg.name }}
                      {%- else %}
      edition: ''
      appname: {{ appcode.pkg.archive.name }}
    - onlyif: test -f "{{ appcode.dir.path }}/{{ appcode.command }}"
                      {%- endif %}
    - require:
      - sls: {{ sls_package_install }}

{%- endif %}

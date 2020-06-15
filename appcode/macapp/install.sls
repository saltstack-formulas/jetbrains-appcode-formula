# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}

appcode-macos-app-install-curl:
  file.directory:
    - name: {{ appcode.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ appcode.dir.tmp }}/appcode-{{ appcode.version }} {{ appcode.pkg.macapp.source }}
    - unless: test -f {{ appcode.dir.tmp }}/appcode-{{ appcode.version }}
    - require:
      - file: appcode-macos-app-install-curl
      - pkg: appcode-macos-app-install-curl
    - retry: {{ appcode.retry_option|json }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
appcode-macos-app-install-checksum:
  module.run:
    - onlyif: {{ appcode.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ appcode.dir.tmp }}/appcode-{{ appcode.version }}
    - file_hash: {{ appcode.pkg.macapp.source_hash }}
    - require:
      - cmd: appcode-macos-app-install-curl
    - require_in:
      - macpackage: appcode-macos-app-install-macpackage
  file.absent:
    - name: {{ appcode.dir.tmp }}/appcode-{{ appcode.version }}
    - onfail:
      - module: appcode-macos-app-install-checksum

appcode-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ appcode.dir.tmp }}/appcode-{{ appcode.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: appcode-macos-app-install-curl
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://appcode/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      appname: {{ appcode.pkg.name }}
      edition: {{ '' if 'edition' not in appcode else appcode.edition }}
      user: {{ appcode.identity.user }}
      homes: {{ appcode.dir.homes }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh
    - runas: {{ appcode.identity.user }}
    - require:
      - file: appcode-macos-app-install-macpackage

    {%- else %}

appcode-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The appcode macpackage is only available on MacOS

    {%- endif %}

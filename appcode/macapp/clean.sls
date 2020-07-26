# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode as a with context %}

a-macos-app-clean-files:
  file.absent:
    - names:
      - {{ a.dir.tmp }}
      - {{ a.config.path }}/{{ a.pkg.name }}{{ '' if 'edition' not in a else ' %sE'|format(a.edition) }}.app

    {%- else %}

a-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The a macpackage is only available on MacOS

    {%- endif %}

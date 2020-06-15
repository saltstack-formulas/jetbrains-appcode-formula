# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}

appcode-macos-app-clean-files:
  file.absent:
    - names:
      - {{ appcode.dir.tmp }}
      - /Applications/{{ appcode.pkg.name }}{{ '' if 'edition' not in appcode else '\ %sE'|format(appcode.edition) }}.app    # noqa 204

    {%- else %}

appcode-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The appcode macpackage is only available on MacOS

    {%- endif %}

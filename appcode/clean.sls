# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('darwin',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import appcode with context %}

include:
  - .macapp.clean
  - .config.clean

    {%- else %}

appcode-not-available-to-install:
  test.show_notification:
    - text: |
        The appcode package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}

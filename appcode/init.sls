{% from "appcode/map.jinja" import appcode with context %}

# Cleanup first
appcode-remove-prev-archive:
  file.absent:
    - name: '{{ appcode.tmpdir }}'
    - require_in:
      - appcode-install-dir

appcode-install-dir:
  file.directory:
    - names:
      - '{{ appcode.jetbrains.realhome }}'
      - '{{ appcode.tmpdir }}'
    - makedirs: True
    - require_in:
      - appcode-download-archive

appcode-download-archive:
  cmd.run:
    - name: curl {{ appcode.dl.opts }} -o '{{ appcode.tmpdir }}/{{ appcode.dl.archive_name }}' {{ appcode.dl.source_url }}
{% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: {{ appcode.dl.retries }}
        interval: {{ appcode.dl.interval }}
{% endif %}

{%- if appcode.dl.src_hashsum %}
   # Check local archive using hashstring for older Salt / MacOS.
   # (see https://github.com/saltstack/salt/pull/41914).
  {%- if grains['saltversioninfo'] <= [2016, 11, 6] or grains.os in ('MacOS',) %}
appcode-check-archive-hash:
   module.run:
     - name: file.check_hash
     - path: '{{ appcode.tmpdir }}/{{ appcode.dl.archive_name }}'
     - file_hash: {{ appcode.dl.src_hashsum }}
     - onchanges:
       - cmd: appcode-download-archive
     - require_in:
       - archive: appcode-package-install
  {%- endif %}

{%- endif %}

appcode-package-install:
  macpackage.installed:
    - name: '{{ appcode.tmpdir }}/{{ appcode.dl.archive_name }}'
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: appcode-download-archive
    - require_in:
      - appcode-remove-archive

appcode-remove-archive:
  file.absent:
    - names:
      # todo: maybe just delete the tmpdir itself
      - '{{ appcode.tmpdir }}/{{ appcode.dl.archive_name }}'
      - '{{ appcode.tmpdir }}/{{ appcode.dl.archive_name }}.sha256'
    - onchanges:
      - macpackage: appcode-package-install


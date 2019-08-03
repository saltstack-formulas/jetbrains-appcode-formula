{% from "appcode/map.jinja" import appcode with context %}

{% if appcode.prefs.user %}

appcode-desktop-shortcut-clean:
  file.absent:
    - name: '{{ appcode.homes }}/{{ appcode.prefs.user }}/Desktop/Appcode'
    - require_in:
      - file: appcode-desktop-shortcut-add
    - onlyif: test "`uname`" = "Darwin"

appcode-desktop-shortcut-add:
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://appcode/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ appcode.prefs.user|json }}
      homes: {{ appcode.homes|json }}
    - onlyif: test "`uname`" = "Darwin"
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ appcode.jetbrains.edition }}
    - runas: {{ appcode.prefs.user }}
    - require:
      - file: appcode-desktop-shortcut-add
    - onlyif: test "`uname`" = "Darwin"


    {% if appcode.prefs.jarurl or appcode.prefs.jardir %}

appcode-prefs-importfile:
  file.managed:
    - onlyif: test -f {{ appcode.prefs.jardir }}/{{ appcode.prefs.jarfile }}
    - name: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
    - source: {{ appcode.prefs.jardir }}/{{ appcode.prefs.jarfile }}
    - user: {{ appcode.prefs.user }}
       {% if appcode.prefs.group and grains.os not in ('MacOS',) %}
    - group: {{ appcode.prefs.group }}
       {% endif %}
    - makedirs: True
    - if_missing: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
    - onlyif: test "`uname`" = "Darwin"
  cmd.run:
    - unless: test -f {{ appcode.prefs.jardir }}/{{ appcode.prefs.jarfile }}
    - name: curl -o {{appcode.homes}}/{{appcode.prefs.user}}/{{appcode.prefs.jarfile}} {{appcode.prefs.jarurl}}
    - runas: {{ appcode.prefs.user }}
    - if_missing: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
    - onlyif: test "`uname`" = "Darwin"
    {% endif %}

{% endif %}


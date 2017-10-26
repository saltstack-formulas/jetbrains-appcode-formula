{% from "appcode/map.jinja" import appcode with context %}

{% if grains.os == 'MacOS' %}

  {% if appcode.prefs.user not in (None, 'undefined_user', 'undefined', '',) %}

appcode-desktop-shortcut-clean:
  file.absent:
    - name: '{{ appcode.homes }}/{{ appcode.prefs.user }}/Desktop/Appcode'
    - require_in:
      - file: appcode-desktop-shortcut-add

appcode-desktop-shortcut-add:
  file.managed:
    - name: /tmp/mac_shortcut.sh
    - source: salt://appcode/files/mac_shortcut.sh
    - mode: 755
    - template: jinja
    - context:
      user: {{ appcode.prefs.user }}
      homes: {{ appcode.homes }}
  cmd.run:
    - name: /tmp/mac_shortcut.sh {{ appcode.jetbrains.edition }}
    - runas: {{ appcode.prefs.user }}
    - require:
      - file: appcode-desktop-shortcut-add

    {% if appcode.prefs.jarurl or appcode.prefs.jardir %}

appcode-prefs-importfile:
      {% if appcode.prefs.jardir %}
  file.managed:
    - onlyif: test -f {{ appcode.prefs.jardir }}/{{ appcode.prefs.jarfile }}
    - name: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
    - source: {{ appcode.prefs.jardir }}/{{ appcode.prefs.jarfile }}
    - user: {{ appcode.prefs.user }}
    - makedirs: True
    - if_missing: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
      {% else %}
  cmd.run:
    - name: curl -o {{appcode.homes}}/{{appcode.prefs.user}}/{{appcode.prefs.jarfile}} {{appcode.prefs.jarurl}}
    - runas: {{ appcode.prefs.user }}
    - if_missing: {{ appcode.homes }}/{{ appcode.prefs.user }}/{{ appcode.prefs.jarfile }}
      {% endif %}

    {% endif %}

  {% endif %}

{% endif %}


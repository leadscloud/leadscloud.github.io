{% if theme.aplayer.enable %}

  <script src="{{ url_for(theme.js) }}/src/APlayer.min.js?v={{ theme.version }}"></script>

  <script type="text/javascript">
    var playlist = [];
    {% for src in theme.aplayer.sources %}
    playlist.push({title:'{{src.title}}', author:'{{src.author}}', url:'{{ src.url }}', pic:'{{ src.pic }}', lrc: '{{ src.lrc }}'})
    {% endfor %}
    var ap = new APlayer({
        element: document.getElementById('aplayer'),
        autoplay: {{ theme.aplayer.autoplay }},
        mode: "{{theme.aplayer.mode}}",
        preload: "{{theme.aplayer.preload}}",
        music: playlist
    });
  </script>

{% endif %}
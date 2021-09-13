<!DOCTYPE html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.use_motion %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>
  <link rel="canonical" href="{{ site.url }}{{ page.url }}" />
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
  {% include '_third-party/analytics/index.swig' %}
  <script type="text/javascript">
    var host = "wellwind.idv.tw";
    if ((host == window.location.host) && (window.location.protocol != "https:")) {
      window.location.protocol = "https";
    }
  </script>
  <div id="fb-root"></div>
  <script async defer crossorigin="anonymous" src="https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v3.3&appId=1148471878668114&autoLogAppEvents=1"></script>
  <style>
  .monaco-theme-highlight-code {
    opacity: 0.4;
    background: skyblue;
    border-radius: 2px;
  }
  </style>
</head>

<body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">

  {% set container_class = "container " %}
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}

  <div class="{{ container_class }} {% block page_class %}{% endblock %} ">
    <div class="headband"></div>

    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner"> {%- include '_partials/header.swig' %} </div>
    </header>

    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap">
          <div id="content" class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_third-party/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>
        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
      </div>
    </main>

    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_third-party/analytics/busuanzi-counter.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
          <i class="material-icons">arrow_upward</i>
        </button>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}

  </div>

  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}
    {% include '_scripts/pages/post-details.swig' %}
  {% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_third-party/comments/index.swig' %}
  {% include '_third-party/search/index.swig' %}
  {% include '_third-party/analytics/lean-analytics.swig' %}
  {% include '_third-party/seo/baidu-push.swig' %}
  {% include '_third-party/rating.swig' %}
  {% include '_third-party/mathjax.swig' %}
  {% include '_third-party/scroll-cookie.swig' %}
  {% include '_third-party/exturl.swig' %}

  <script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.27.0/min/vs/loader.min.js"></script>
  <script>
  function parseCodeArgs(settingString) {
    const result = {
      lang: '',
      highlightLines: null,
      highlightWholeLine: null
    };

    const settings = settingString.split(';');

    // language
    result.lang = settings[0];

    // another arguments
    for(let i = 1; i < settings.length; ++i) {
      const setting = settings[i];
      const [key, value] = setting.split('=');

      if(key === 'highlightLines') {
        const [ startLineNumber, startColumn, endLineNumber, endColumn ] = value.split(':');
        result.highlightLines = {
          startLineNumber: +startLineNumber,
          startColumn: +startColumn,
          endLineNumber: +endLineNumber,
          endColumn: +endColumn
        }
      } else if(key === 'highlightWholeLine') {
        result.highlightWholeLine = value === 'true';
      }
    }
    return result;
  }

  require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.27.0/min/vs' }});

  window.MonacoEnvironment = {
    getWorkerUrl: function(workerId, label) {
      return `data:text/javascript;charset=utf-8,${encodeURIComponent(`
        self.MonacoEnvironment = {
          baseUrl: 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.27.0/min/'
        };
        importScripts('https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.27.0/min/vs/base/worker/workerMain.js');`
      )}`;
    }
  };

  require(["vs/editor/editor.main"], function () {
    const fontSize = 19;
    document.querySelectorAll('pre code').forEach(code => {
      var codeSettings = parseCodeArgs(code.classList[0]);

      code.parentElement.style.overflow = 'hidden';
    
      const codeText = code.innerText;
      code.innerText = '';
      code.style.height = `${(codeText.split('\n').length + 1) * fontSize}px`;
      code.style.display = 'block';
          
      const instance = monaco.editor.create(code, {
        value: codeText,
        theme: 'vs-dark',
        language: codeSettings.lang,
        glyphMargin: true,
        scrollBeyondLastLine: false,
        readOnly: true,
          minimap: {
            enabled: false
        }
      });

      if(codeSettings.highlightLines) {
        console.log(codeSettings);
        const highlightLines = codeSettings.highlightLines;
        instance.deltaDecorations([], [
          {
            range: new monaco.Range(
              highlightLines.startLineNumber,
              highlightLines.startColumn,
              highlightLines.endLineNumber,
              highlightLines.endColumn
            ),
            options: {
              isWholeLine: codeSettings.highlightWholeLine,
              className: 'monaco-theme-highlight-code'
            }
          }
        ]);
      }
    });
  });
  </script>

  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

  <script>
    (function displayCourses() {
      if($('.post-body').length === 1) {
        // var content = '<section id="displayCourses"><h1 id="工商服務"><a href="#工商服務" title="工商服務"></a>工商服務</h1><p>對 Angular 已經有點經驗，但總覺得寫得不夠漂亮；或是沒什麼練功機會嗎？歡迎參加 「<a href="https://www.accupass.com/event/1902210115431858444097" target="_blank">Angular 7 開發實戰：進階開發篇</a>」，學習更進一步的 Angular 知識；也可以參加「<a href="" target="_blank">Angular 7 開發實戰：進階實作篇</a>」，透過一個實際專案學習更多的實務經驗！！</p><p><a href="https://www.accupass.com/event/1902210115431858444097" target="_blank"><img src="https://az796311.vo.msecnd.net/userupload/a4147fbf9de44b7a82d5b7bcd1013e4d.jpg" /></a></p><p><a href="https://www.accupass.com/event/1902210116001899039507" target="_blank"><img src="https://az796311.vo.msecnd.net/userupload/f6d314c5d01f4fbeae05ae86a87aaa20.jpg" /></a></p></section>';
        var content = '';
        $('.post-body').append(content);
        setTimeout(function() {
          $('#displayCourses a').removeClass('fancybox');
          $('#displayCourses a').removeClass('fancybox.image');
        }, 1000)
      }
    })();
  </script>
</body>
</html>

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
  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

  <script>
    (function displayCourses() {
      if($('.post-body').length === 1) {
        var content = '<section id="displayCourses"><h1 id="工商服務"><a href="#工商服務" title="工商服務"></a>工商服務</h1><p>如果你是對 Angular 有興趣的新手，建議可以參加 「<a href="https://www.accupass.com/event/1901240229371238325763" target="_blank" >Angular 7 開發實戰：新手入門篇</a>」，由保哥替你打下紮實的基礎觀念！有一點基礎理解後，我會在 「<a href="https://www.accupass.com/event/1901240309585287122000" target="_blank" >Angular 7 開發實戰：新手實作篇</a>」手把手帶給你豐富的實戰經驗！對於想入門卻不知道該如何進入的朋友，千萬不要錯過啦！</p><p><a href="https://www.accupass.com/event/1901240229371238325763" target="_blank">學習紮實的基本觀念</a>：</p><p><a href="https://www.accupass.com/event/1901240229371238325763" target="_blank"><img src="https://az796311.vo.msecnd.net/userupload/87220fe1743249efb639982a246b237c_P520x260.jpg"  alt="Angular 7 開發實戰：新手入門篇"></a></p><p><a href="https://www.accupass.com/event/1901240309585287122000" target="_blank">學習業界的實戰經驗</a>：</p><p><a href="https://www.accupass.com/event/1901240309585287122000" target="_blank"><img src="https://az796311.vo.msecnd.net/userupload/f9e530ee76944e5e8197f3222d4d202f_P520x260.jpg" alt="Angular 7 開發實戰：新手實作篇"></a></p></sect>';
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

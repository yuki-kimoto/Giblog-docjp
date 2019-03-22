<!DOCTYPE html>
<html>
  <head>
    <!-- meta -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/common.css">

  </head>
  <body>
    <div class="container">
      <div class="header">
        <!-- header -->
<h1>
  <a href="/">Giblog - git世代のためのブログ作成ツール</a>
</h1>

      </div>
      <div class="main">
        <div class="content">
          <div class="entry">
  <div class="top">
    <!-- top -->

  </div>
  <div class="middle">
    <p>
  use strict;
</p>
<p>
  use warnings;
</p>
<p>
  my $cmd = 'giblog build';
</p>
<p>
  system($cmd) == 0
</p>
  or die "Can't execute $cmd: $!";
<p>
  use Mojolicious::Lite;
</p>
<p>
  get '/' => sub {
</p>
  my $c = shift;
  
  $c->reply->static('index.html');
<p>
  };
</p>
<p>
  app->start;
</p>

  </div>
  <div class="bottom">
    <!-- bottom -->

  </div>
</div>

        </div>
        <div class="side">
          <!-- side -->
<div class="side-list">
  <div class="side-list-title">
    ドキュメント
  </div>
  <ul>
    <li><a href="/">Giblog</a></li>
    <li><a href="/Giblog/API.html">Giblog::API</a></li>
  </ul>
</div>

        </div>
      </div>
      <div class="footer">
        <!-- footer -->
<a href="https://github.com/yuki-kimoto/giblog">Giblog</a>

      </div>
    </div>
  </body>
</html>

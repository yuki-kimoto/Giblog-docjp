=encoding utf8

=head1 名前

Giblog - Gitで管理できるWebサイトとブログの作成ツール

=begin html

<p>
  <b>Webサイト</b>
</p>
<p>
  <a href="https://new-website-example.giblog.net/"><img src="https://github.com/yuki-kimoto/giblog/raw/master/images/giblog-website.png"></a>
</p>
<p>
  <a href="https://new-website-example.giblog.net/">Webサイトのサンプル</a>
</p>
<p>
  <b>ブログ</b>
</p>
<p>
  <a href="https://new-blog-example.giblog.net/"><img src="https://github.com/yuki-kimoto/giblog/raw/master/images/giblog-blog.png"></a>
</p>
<p>
  <a href="https://new-blog-example.giblog.net/">ブログのサンプル</a>
</p>

=end html

=head1 説明

GiblogはPerlで書かれたWebサイトとブログの作成ツールです。
Webサイトとブログを簡単に作成できます。
作られるファイルはすべて静的なファイルで、gitを使って管理することができます。
Perlを使って、Webサイトを自由にカスタマイズできます。

=head1 使い方
  
  # 新しく空のWebサイトを作成
  giblog new mysite

  # 新しくWebサイトを作成
  giblog new_website mysite

  # 新しくブログを作成
  giblog new_blog mysite
  
  # ディレクトリ変更
  cd mysite
  
  # 新しいエントリーを追加
  giblog add

  # Webサイトを構築
  giblog build

  # Webサイトのサーブ
  $ giblog serve

  # Webサイトの公開
  $ giblog publish origin main

  # ローカル環境でWebサイトを確認(Mojoliciousが必要)
  morbo serve.pl

  # ホームディレクトリを指定して新しいエントリーを追加
  giblog add --home /home/kimoto/mysite
  
  # ホームディレクトリを指定して、Webサイトを構築
  giblog build --home /home/kimoto/mysite

=head1 機能

Giblogは、以下の機能を持っています。

=over 4

=item * Webサイトとブログ作成の両方に対応。

=item * gitですべてのファイルを管理できる

=item * Linux、macOS、Windows対応。Windowsでは、msys2のインストールを推奨。

=item * スマートフォン対応のデフォルトのCSSを提供。

=item * ヘッダ・フッタ・サイドバーをサポート

=item * コンテンツのトップとボトムをカスタマイズ可能。

=item * HTMLヘッダをカスタマイズ可能。

=item * 自動的な改行。pタグを自動追加。

=item * preタグの中でE<lt>、E<gt>を、自動的にエスケープ。

=item * 最初の見出しタグ(h1～h6)から自動的にtitleを設定。

=item * 最初の段落タグ(p)から自動的にdescriptionを設定。

=item * Perlを使ってWebサイトを自由にカスタマイズできる

=item * ローカル環境でWebサイトを確認可能。コンテンツの変更を検知して、自動的に再構築(Mojoliciousが必要)

=item * 速い。標準的なLinux環境で、645ページを、0.78秒で構築。

=back

=head1 チュートリアル

=head2 Webサイトの作成

B<1. 空のWebサイトを作成>

「new」コマンドで、空のWebサイトを作成します。「mysite」はWebサイトの名前のひとつの例です。

  giblog new mysite

空のWebサイトを作成したい場合は、このコマンドを選んでください。
テンプレートとCSSは空で、最低限のWebサイトの構築処理のみを提供します。

B<2.  Webサイトを作成>

「new_website」コマンドで、空のWebサイトを作成します。

  giblog new_website mysite

Webサイトを作成したい場合は、このコマンドを選んでください。
トップページのテンプレート「templates/index.html」が作成されます。
記事のリストを表示した「templates/list.html」作成されます。これは、将来ブログの記事を作成するときにために用意されています。

CSSは、レスポンシブデザインで、スマートフォンに対応しています。
基本的なWebサイトのビルドスクリプトが提供されます。

B<3. ブログを作成>

「new_blog」コマンドで、ブログを作成します。

  giblog new_blog mysite

ブログを作成したい場合は、このコマンドを選んでください。
7日間のエントリーを表示したトップページ「templates/index.html」が作成されます。
すべてのページへのリンクを表示した「templates/list.html」が作成されます。

CSSは、レスポンシブデザインで、スマートフォンに対応しています。
基本的なブログの構築処理が提供されます。

=head2 ブログのエントリーページの追加

他のディレクトリにいる場合は、「add」コマンドを実行する前に「mysite」にディレクトリを変更する必要があります。

  cd mysite

「add」コマンドを使って、ブログのエントリページを追加します。
  
  giblog add

作成されたファイル名は、例えば、以下のようになります。

  templates/blog/20080108132865.html

このファイル名は、現在の日付と時刻を含みます。

新しく記事を書くには、このファイルを開いて、 h2とコンテンツを書きます。

  <h2>How to use Giblog</h2>

  Giblogの使い方。これは...。

ヘッダとフッタなどのコンテンツを囲むパーツは、構築処理で、自動的に追加されます。

=head2 コンテンツページの追加

コンテンツページを作成したい場合は、ファイルを「templates」ディレクトリの中に配置します。

  templates/access.html
  templates/profile.html

新しく記事を書くには、このファイルを開いて、 h2とコンテンツを書きます。

  <h2>How to use Giblog</h2>

  Giblogの使い方。これは...。

ヘッダとフッタなどのコンテンツを囲むパーツは、構築処理で、自動的に追加されます。

サブディレクトリに、ファイルを置くこともできます。

  templates/profile/more.html

「templates/static」と「templates/common」は特別なディレクトリであることに注意してください。
これらのディレクトリに、コンテントページのファイルを配置しないでください。

  # コンテンツファイルを配置してはいけない特別なディレクトリ
  templates/static
  templates/common

=head2 静的ページの追加

CSSや画像やJavaScriptなどの静的なファイルを追加したいときは
それらのファイルを「templates/static」ディレクトリに配置してください。

「templates/static」ディレクトリにあるファイルは、構築処理で、単にコピーされます。

  templates/static/js/jquery.js
  templates/static/images/logo.png
  templates/static/css/more.css

=head2 ヘッダ、フッタ、サイドバー、コンテンツの上、コンテンツの下のカスタマイズ

ヘッダ、フッタ、サイドバー、コンテンツの上、コンテンツの下のカスタマイズができます。
  
  ------------------------
  ヘッダ
  ------------------------
  コンテンツの上   |
  -----------------|
                   |サイド
  コンテンツ       |バー
                   |
  -----------------|
  コンテンツの下   |
  ------------------------
  フッタ
  ------------------------

これらの部分を編集したい場合は、以下のファイルを編集してください。

  templates/common/header.html     ヘッダ
  templates/common/top.html        コンテンツの上
  templates/common/side.html       サイドバー
  templates/common/bottom.html     コンテンツの下
  templates/common/footer.html     フッタ

=head2 HTMLヘッダの編集

HTMLヘッダをカスタマイズすることができます。

  <html>
    <head>
      <!-- HTML header -->
    </head>
    <body>
    
    </body>
  </html>

HTMLヘッダを編集したい場合は、以下のファイルを編集してください。

  templates/common/meta.html

=head2 Webサイトの構築

他のディレクトリにいる場合は「build」コマンドを実行する前に「mysite」にディレクトリを変更してください。

  cd mysite

「build」コマンドを使うと、Webサイトを構築できます。

  giblog build

構築処理とは、いったい何ですか?

構築処理は「lib/Giblog/Command/build.pm」の中の「run」メソッドに書かれています。
  
  # "lib/Giblog/Command/build.pm" in web site created by "new_blog" command
  package Giblog::Command::build;

  use base 'Giblog::Command';

  use strict;
  use warnings;

  use File::Basename 'basename';

  sub run {
    my ($self, @args) = @_;

    # API
    my $api = $self->api;

    # Read config
    my $config = $api->read_config;

    # Copy static files to public
    $api->copy_static_files_to_public;

    # Get files in templates directory
    my $files = $api->get_templates_files;

    for my $file (@$files) {
      # Data
      my $data = {file => $file};

      # Get content from file in templates directory
      $api->get_content($data);

      # Parse Giblog syntax
      $api->parse_giblog_syntax($data);

      # Parse title
      $api->parse_title_from_first_h_tag($data);

      # Edit title
      my $site_title = $config->{site_title};
      if ($data->{file} eq 'index.html') {
        $data->{title} = $site_title;
      }
      else {
        $data->{title} = "$data->{title} - $site_title";
      }

      # Add page link
      $api->add_page_link_to_first_h_tag($data, {root => 'index.html'});

      # Parse description
      $api->parse_description_from_first_p_tag($data);

      # Read common templates
      $api->read_common_templates($data);

      # Add meta title
      $api->add_meta_title($data);

      # Add meta description
      $api->add_meta_description($data);

      # Build entry html
      $api->build_entry($data);

      # Build whole html
      $api->build_html($data);

      # Write to public file
      $api->write_to_public_file($data);
    }

    # Create index page
    $self->create_index;

    # Create list page
    $self->create_list;
  }

もし必要であれば、自分自身でこの構築処理をカスタマイズできます。

runメソッドの中のAPIを理解したい場合は、L<Giblog::API>を見てください。

=head2 Webサイトのサーブ

もしL<Mojolicious|https://metacpan.org/pod/Mojolicious>がインストールされていれば、Webサイトをローカル環境でチェックできます。

   morbo serve.pl

以下のメッセージが表示されます。

   Server available at http://127.0.0.1:3000
   Server start

ブラウザから上記のURLでWebサイトを確認できます。

Webサイトは「templates」ディレクトリの中のファイルが変更されると
自動的に再構築されます。
手動で「build」コマンドを実行する必要はありません。

=head1 設定ファイル

Giblogの設定ファイルはC<giblog.conf>です。

これはPerlスクリプトで、ハッシュリファレンスで設定を返します。

  use strict;
  use warnings;
  use utf8;

  # giblog.conf
  {
    site_title => 'mysite😄',
    site_url => 'http://somesite.example',
  }

=head2 site_title

  site_title => 'mysite😄'

サイトタイトル。

=head2 site_url

  site_url => 'http://somesite.example'

サイトURL。

=head2 base_path

  base_path => '/subdir'

ベースパス。ベースパスは、あなたのサイトをサブディレクトリで配置するときに利用されいます。

たとえば、Github PagesのプロジェクトページのURLが以下だったとしましょう。

  https://yuki-kimoto.github.io/giblog-theme1-public/

以下を指定します。

  base_path => '/giblog-theme1-public'

最初の文字は、スラッシュであるC</>で始まる必要があります。

HTMLファイルは、C<public/giblog-theme1-public>ディレクトリに出力されます。

=head1 メソッド

これらのメソッドは、内部的なメソッドです。

通常は、これらのメソッドを知る必要はありません。

HTMLコンテンツを扱いたい場合はL<Giblog::API>を見てください。

=head2 new

  my $api = Giblog->new(%params);

L<Giblog>オブジェクトを作成します。

B<パラメーター:>

=over 4

=item * home_dir - ホームディレクトリ

=item * config - 設定

=back

=head2 run_command

  $giblog->run_command(@argv);

コマンドシステムを実行します。

=head2 config

  my $config = $giblog->config;

Giblogの設定を取得。

=head2 home_dir

  my $home_dir = $giblog->home_dir;

ホームディレクトリを取得。

=head1 ドキュメント

=over 2

=item * L<Giblog>

=item * L<Giblog::API>

=item * L<Giblog::Command>

=item * L<Giblog::Command::new>

=item * L<Giblog::Command::new_website>

=item * L<Giblog::Command::new_blog>

=item * L<Giblog::Command::add>

=item * L<Giblog::Command::build>

=item * L<Giblog::Command::serve>

=item * L<Giblog::Command::publish>

=back

=head1 FAQ

=head2 GiblogはWindowsをサポートしますか?

GiblogはGitとMojoliciousに依存しているため、GiblogはネイティブWindows（Strawberry Perl、またはActive Perl）をサポートしていません。

WindowsでGiblogを使用したい場合は、WSL2を利用できます。

=head2 GiblogがサポートするPerlの最低のバージョンは何ですか?

GiblogはMojoliciousに依存しているために、Mojoliciousが要求するPerlの最低のバージョンになります。現在はPerl 5.16+です。

=head2 Giblogが必要とするGitの最低バージョンは何ですか?

Git 1.8.5+です。

=head2 Giblog 1からGiblog 2へアップグレードする場合の注意点は何ですか?

Giblog 2.0からは、Perlの最低バージョンは、Mojoliciousに依存するので、できる限り新しいPerlを利用してください。

Git 1.8.5+が必要です。

=head1 Giblog公式サイト

L<Giblog公式サイト|https://jp.giblog.net/>

=head1 著者

木本裕紀, C<< <kimoto.yuki at gmail.com> >>

=head1 ライセンスとコピーライト

Copyright 2018-2021 Yuki Kimoto.

このプログラムはフリーソフトウェアです。 Artistic License（2.0）の条件の下でそれを再配布および/または修正することができます。あなたは完全なライセンスのコピーを以下から入手することができます。

L<http://www.perlfoundation.org/artistic_license_2_0>

=cut

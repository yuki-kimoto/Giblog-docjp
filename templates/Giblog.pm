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

「build」コマンドを使うと、Webサイトを構築できます。

  giblog build

「build」コマンドを実行する前に、「mysite」にディレクトリを変更する必要があります。

  cd mysite

「--home」オプションを使用した場合は、ディレクトリを変更する必要はありません。

  giblog build --home /home/kimoto/mysite

構築プロセスとは、いったい何でしょうか。

構築プロセスは「lib/Giblog/Command/build.pm」の中の「run」メソッドに書かれています。

構築プロセスの主な部分は、L<Giblog::API>の組み合わせです。
  
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

「run」メソッドは、「templates」ディレクトリの中のすべてのテンプレートファイルを読み込み、編集し、「public」ディレクトリの中のファイルへ、出力を書き込みます。

もし必要であれば、自分自身でこの構築プロセスを編集できます。

runメソッドの中のAPIを理解する必要がある場合は、L<Giblog::API>を見てください。

=head2 Webサイトのサーブ

もしMojoliciousを持っていれば、Webサイトの構築とサーブができます。

   morbo serve.pl

以下のメッセージが表示されます。

   Server available at http://127.0.0.1:3000
   Server start

「templates」ディレクトリの中のファイルが、更新されると、ビルドされ、サーバーは自動的にリロードされます。

=head1 著者

Perlゼミ(木本裕紀), C<< <kimoto.yuki at gmail.com> >>

=head1 ライセンスとコピーライト

Copyright 2018-2019 Yuki Kimoto.

このプログラムはフリーソフトウェアです。 Artistic License（2.0）の条件の下でそれを再配布および/または修正することができます。あなたは完全なライセンスのコピーを以下から入手することができます。

L<http://www.perlfoundation.org/artistic_license_2_0>

=cut

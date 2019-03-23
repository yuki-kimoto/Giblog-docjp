=encoding utf8

=head1 名前

Giblog - git世代のためのブログ生成ツール

=head1 説明

GiblogはPerlで書かれたブログ生成ツールです。Webサイトとブログを簡単に作成できます。作られたファイルはすべて静的なHTMLで、gitを使って管理することができます。

Giblogは1.0へのリリースに向かってベータテスト中です。機能が警告なく変更されることがあるので、注意してください。

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
  
  # Webサイトをサーブ(Mojoliciousが必要です)
  morbo serve.pl

  # ホームディレクトリを指定して新しいエントリーを追加
  giblog add --home /home/kimoto/mysite
  
  # ホームディレクトリを指定して、Webサイトを構築
  giblog build --home /home/kimoto/mysite

=head1 機能

Giblogは、以下の機能を持っています。

=over 4

=item * Webサイトとブログ作成の両方に対応。

=item * Linux、Mac OS、Windows対応。Windowsでは、msys2のインストールを推奨。

=item * スマートフォン対応を意識した、デフォルトのCSSを提供。

=item * コンテンツを、トップ、ボトム、サイドバー、ヘッダー、フッター、HTMLヘッダで囲んで出力。

=item * pタグをを自動追加。preタグの中でE<lt>、E<gt>を、自動的にエスケープ。

=item * 最初の見出しタグ(h1～h6)から自動的にtitleに設定。

=item * 最初の段落を自動的にdescriptionに設定。

=item * 機能のカスタマイズは、自由自在。すべてをなくすことも、自由に選ぶことも、機能を追加することも可能。

=item * 機能の追加では、一覧ページをカスタマイズしたり、マークダウンを使ったり、Twitterカードを設定したりできます。

=item * Mojoliciousのmorboコマンドを使って、Webサーバーを起動してWebサイトを確認可能。コンテンツやヘッダなどの変更を検知して、自動的に再構築されます。

=item * ベンチマークでは、私の標準的なLinux環境において、645ページを、0.78秒で構築。

=item * JavaScriptの利用制限なし。アフェリエイト広告を張ることも自由。

=item * gitでファイルを管理して、さくらのレンタルサーバーなどに、配置すれば、HTTPSに対応した情報発信サイトを、個数無制限・低価格(ディスク容量100Gで515円)で作成できます。

=item * Github Pagesを利用すれば、手順が少し難しいですが、HTTPSに対応した情報発信サイトを無料で作成できます。

=item * Perlゼミのサイト構築に実際に利用されています。

=back

=head1 チュートリアル

=head2 Webサイトの作成

３つのプロトタイプからWebサイトを作成できます。

B<1. 空のWebサイト>

「new」コマンドで、空のWebサイトを作成します。「mysite」はWebサイトの名前の一例です。

  giblog new mysite

もし空のWebサイトを作成したい場合は、このプロトタイプを選んでください。

テンプレートとCSSは空で、最低限の構築プロセスのみを提供します。

B<2.  Webサイト>

「new_website」コマンドで、空のWebサイトを作成します。

  giblog new_website mysite

もし、Webサイトを作成したい場合は、このプロトタイプを選んでください。

トップページのテンプレート「templates/index.html」が作成されます。

CSSは、スマートフォンサイトに適合しており、基本的な構築プロセスが提供されます。

B<3. ブログ>

"new_blog" command create empty website. 

  giblog new_blog mysite

ブログを作成したい場合は、このプロトタイプを選んでください。

7日間のエントリーを表示したトップページ「templates/index.html」が作成されます。

すべてのページへのリンクを表示した「templates/list.html」が作成されます。

CSSは、スマートフォンサイトに適合しており、基本的な構築プロセスが提供されます。

=head2 エントリーページの追加

「add」コマンドを使って、ブログのエントリページを追加することができます。
  
  giblog add

「add」コマンドを実行する前に、「mysite」にディレクトリを変更する必要があります。

  cd mysite

「--home」オプションを使う場合は、ディレクトリを変更する必要はありません。

  giblog add --home /home/kimoto/mysite

作成されたファイル名は、例えば、以下のようになります。

  templates/blog/20080108132865.html

このファイル名は、日付と時刻を含みます。

=head2 Webサイトの構築

"build"コマンドを使うと、Webサイトを構築できます。

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

Copyright 2018 Yuki Kimoto.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

=cut

=encoding utf8

=head1 名前

Giblog::API - Giblog API

=head1 説明

Giblog::APIではHTMLコンテンツを扱うためのメソッドを定義しています。

=head1 メソッド

=head2 new

  my $api = Giblog::API->new(%params);

L<Giblog::API>オブジェクトを作成します。

B<パラメーター:>

=over 4

=item * giblog - L<Giblog>オブジェクト

=back

「giblog」メソッドを呼び出せば、このパラメータにアクセスできます。

  my $giblog = $api->giblog;

=head2 giblog

  my $giblog = $api->giblog;

L<Giblog>オブジェクトを取得します。

=head2 config

  my $config = $api->config;

Giblogのコンフィグを取得します。これは、ハッシュリファレンスです。

コンフィグは「read_config」メソッドによって、ロードできます。

コンフィグがロードされていない場合は、このメソッドを未定義値を返します。

=head2 home_dir

  my $home_dir = $api->home_dir;

ホームディレクトリを取得します。

=head2 read_config

  my $config = $api->read_config;

ホームディレクトリの「giblog.conf」を解析して、ハッシュリファレンスを返します。

「giblog.conf」は正しいハッシュリファレンスで終わる必要があります。そうでなければ、例外が発生します。
  
  # giblog.conf
  {
    site_title => 'mysite',
    site_url => 'http://somesite.example',
  }

「read_config」を呼び出した後は、「config」メソッドで、コンフィグを取得することができます。

=head2 clear_config

  $api->clear_config;

コンフィグをクリアします。未定義値がコンフィグに設定されます。

=head2 create_dir

  $api->create_dir($dir);

ディレクトリを作成します。

ディレクトリの作成に失敗した場合は、例外が発生します。

=head2 create_file

  $api->create_file($file);

ファイルを作成します。

ファイルの作成に失敗した場合は、例外が発生します。

=head2 write_to_file

  $api->write_to_file($file, $content);

コンテンツをファイルに書き込みます。コンテンツはUTF-8にエンコードされます。

ファイルが存在していない場合は、自動的に作成されます。

ファイルの作成に失敗すれば、例外が発生します。

=head2 slurp_file

  my $content = $api->slurp_file($file);

ファイルのコンテンツを取得します。コンテンツは、UTF-8からデコードされます。

ファイルが存在しない場合は、例外が発生します。

=head2 rel_file

  my $file = $api->rel_file('foo/bar');

ホームディレクトリのパスと指定された相対パスを結合したものを返します。

ホームディレクトリが設定されていない場合は、指定されたパスを返します。

=head2 run_command

  $api->run_command($command_name, @args);

コマンドクラスをロードして、オブジェクトを作成し、「run」メソッドを実行します。

たとえば、コマンド名が「build」で、対応する「Giblog::Command::build」モジュールがロードされたとすれば、このオブジェクトが生成され、「run」メソッドが実行されます。

モジュールのロードに失敗すると、例外が発生します。

=head2 create_website_from_proto

  $api->create_website_from_proto($home_dir, $module_name);

Webサイトのホームディレクトリを作成し、プロトタイプディレクトリからファイルをコピーします。

プロトタイプディレクトリは、モジュール名から自動的に検知されます。

モジュール名が「Giblog::Command::new_foo」で、ロードされたパスが「lib/Giblog/Command/new_foo.pm」であれば、プロトタイプディレクトリは「lib/Giblog/Command/new_foo/proto」になります。

  lib/Giblog/Command/new_foo.pm
                    /new_foo/proto

モジュールは「create_website_from_proto」呼び出される前にロードされる必要があります。そうでなければ、例外が発生します。

ホームディレクトリが設定されていない場合は、例外が発生します。

ホームディレクトリがすでに存在していた場合は、例外が発生します。

ディレクトリの作成に失敗した場合は、例外が発生します。

モジュール名に対応するプロトタイプディレクトリが指定されなかった場合は、例外が発生します。

モジュール名に対応するプロトタイプディレクトリが見つからなかった場合は、例外が発生します。

=head2 copy_static_files_to_public

  $api->copy_static_files_to_public;

「templates/static」ディレクトリの中の静的ファイルを「public」ディレクトリにコピーします。

=head2 get_templates_files

  my $files = $api->get_templates_files;

ホームディレクトリの中の「templates」ディレクトリからファイル名の一覧を取得します。

「templates/common」ディレクトリと「templates/static」ディレクトリと隠しファイル(「.」で始まるもの) は含まれません。

取得したファイル名は「templates」ディレクトリからの相対パスです。

たとえば、以下のようなファイル名です。

  index.html
  blog/20190312121345.html
  blog/20190314452341.html

=head2 get_content

  $api->get_content($data);

「templates」ディレクトリからの相対ファイル名からコンテンツを取得します。コンテンツは、UTF-8からデコードされます。

B<入力:>

  $data->{file}

B<出力:>

  $data->{content}
  
B<サンプル:>
  
  # templates/index.htmlからコンテンツを取得
  $data->{file} = 'index.html';
  $api->get_content($data);
  my $content = $data->{content};

=head2 parse_giblog_syntax

  $api->parse_giblog_syntax($data);

入力テキストを「Giblog syntax」として解析し、出力を返します。

B<入力:>

  $data->{content}

B<出力:>

  $data->{content}
  
B<サンプル:>
  
  # 入力をGiblog記法として解析
  $data->{content} = <<'EOS';
  Hello World!

  <b>Hi, Yuki</b>

  <div>
    OK
  </div>

  <pre>
  my $foo = 1 > 3 && 2 < 5;
  </pre>
  EOS
  
  $api->parse_giblog_syntax($data);
  my $content = $data->{content};

B<Giblog記法>

Giblog記法は、コンテンツを簡単に記述するための簡潔な記法です。

=over 4

=item 1. pタグを自動的に追加

行の先頭がインライン要素で始まった場合は、自動的にpタグが追加されます。

  # 入力
  Hello World!
  
  <b>Hi, Yuki</b>
  
  <div>
    OK
  </div>
  
  # 出力
  <p>
    Hello World!
  </p>
  <p>
    <b>Hi, Yuki</b>
  </p>
  <div>
    OK
  </div>

空の行は削除されます。

=item 2. preタグの中にあるE<gt>とE<lt>をエスケープ

行の先頭がpreタグで始まり、行の先頭がpreの終了タグで始まる行の間で、E<gt>とE<lt>をHTMLエスケープします。
  
  # 入力
  <pre>
  my $foo = 1 > 3 && 2 < 5;
  </pre>

  # 出力
  <pre>
  my $foo = 1 &gt; 3 && 2 &lt; 5;
  </pre>

=back

=head2 parse_title

  $api->parse_title($data);

クラス名が「title」のタグのテキストからタイトル(title)を取得します。

タイトルを取得できない場合は、タイトルは未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{title}

B<サンプル:>
  
  # タイトルを取得
  $data->{content} = <<'EOS';
  <div class="title">Perl Tutorial</div>
  EOS
  $api->parse_title($data);
  my $title = $data->{title};

=head2 parse_title_from_first_h_tag

  $api->parse_title_from_first_h_tag($data);

最初のh1, h2, h3, h4, h5, h6タグのテキストからタイトル(title)を取得します。

タイトルを取得できない場合は、タイトルは未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{title}

B<サンプル:>
  
  # タイトルを取得
  $data->{content} = <<'EOS';
  <h1>Perl Tutorial</h1>
  EOS
  $api->parse_title_from_first_h_tag($data);
  my $title = $data->{title};

=head2 add_page_link

  $api->add_page_link($data);
  $api->add_page_link($data, $opt);

クラス名が「title」のタグのテキストにページリンクを追加します。

タイトルを取得できない場合は、コンテンツは変化しません。

B<入力:>

  $data->{file}
  $data->{content}

B<出力:>

  $data->{content}

「file」は、「templates」ディレクトリからの相対パスです。

追加されるリンクは、「/」と「file」の値を結合したものです。

$opt->{root}が指定されている場合は、これが$data->{file}にマッチした場合は、追加されるリンクは「/」になります。

B<サンプル:>
  
  # ページリンクを追加
  $data->{file} = 'blog/20181012123456.html';
  $data->{content} = <<'EOS';
  <div class="title">Perl Tutorial</div>
  EOS
  $api->add_page_link($data);
  my $content = $data->{content};

コンテンツは以下に変更されます。

  <div class="title"><a href="/blog/20181012123456.html">Perl Tutorial</a></div>

B<Example: root page>

  # ページリンクを追加
  $data->{file} = 'index.html';
  $data->{content} = <<'EOS';
  <div class="title">Perl Tutorial</div>
  EOS
  $api->add_page_link($data);
  my $content = $data->{content};

コンテンツは以下に変更されます。

  <div class="title"><a href="/">Perl Tutorial</a></div>

=head2 add_page_link_to_first_h_tag

  $api->add_page_link_to_first_h_tag($data);
  $api->add_page_link_to_first_h_tag($data, $opt);

ページリンクを最初のh1, h2, h3, h4, h5, h6タグのテキストに追加します。

タイトルを取得できない場合は、コンテンツは変更されません。

B<入力:>

  $data->{file}
  $data->{content}

B<出力:>

  $data->{content}

「file」は「templates」ディレクトリからの相対パスです。

追加されるリンクは、「/」と「file」の値を結合したパスです。

$opt->{root}が指定されており、これが$data->{file}にマッチした場合は、追加されるリンクは「/」になります。

B<サンプル: エントリーページ>
  
  # ページリンクを追加
  $data->{file} = 'blog/20181012123456.html';
  $data->{content} = <<'EOS';
  <h1>Perl Tutorial</h1>
  EOS
  $api->add_page_link_to_first_h_tag($data);
  my $content = $data->{content};

コンテンツは、以下に変更されます。

  <h1><a href="/blog/20181012123456.html">Perl Tutorial</a></h1>

B<サンプル: ルート>

  # ページリンクを追加
  $data->{file} = 'index.html';
  $data->{content} = <<'EOS';
  <h1>Perl Tutorial</h1>
  EOS
  $api->add_page_link_to_first_h_tag($data);
  my $content = $data->{content};

コンテンツは以下に変更されます。

  <h1><a href="/">Perl Tutorial</a></h1>

=head2 parse_description

  $api->parse_description($data);

クラス名が「description」のタグのテキストから説明(description)を取得します。

左右の空白文字は、削除されます。これは、Unicodeの空白文字です。

説明が取得できなかった場合は、説明は、未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{description}

B<サンプル:>
  
  # 説明を取得
  $data->{content} = <<'EOS';
  <div class="description">
    Perl Tutorial is site for beginners of Perl 
  </div>
  EOS
  $api->parse_description($data);
  my $description = $data->{description};

出力の説明は「Perl Tutorial is site for beginners of Perl」になります。

=head2 parse_description_from_first_p_tag

  $api->parse_description_from_first_p_tag($data);

最初のpタグのテキストから説明を取得します。

HTMLタグは、削除されます。

左右の空白文字は削除されます。これは、Unicodeの空白文字です。

説明が取得できなかった場合は、説明は、未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{description}

B<サンプル:>
  
  # 説明を取得
  $data->{content} = <<'EOS';
  <p>
    Perl Tutorial is site for beginners of Perl 
  </p>
  <p>
    Foo, Bar
  </p>
  EOS
  $api->parse_description_from_first_p_tag($data);
  my $description = $data->{description};

Output description is "Perl Tutorial is site for beginners of Perl".

=head2 parse_keywords

  $api->parse_keywords($data);

クラス名が「keywords」のタグのテキストからキーワード(keywords)を取得します。

キーワードが取得できなかった場合は、キーワードは、未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{keywords}

B<サンプル:>
  
  # キーワードの取得
  $data->{content} = <<'EOS';
  <div class="keywords">Perl,Tutorial</div>
  EOS
  $api->parse_keywords($data);
  my $keywords = $data->{keywords};

=head2 parse_first_img_src

  $api->parse_first_img_src($data);

最初のimgタグのsrc属性からイメージソースを取得します。

イメージソースを取得できなかった場合は、イメージソースは未定義値になります。

B<入力:>

  $data->{content}

B<出力:>

  $data->{img_src}

B<サンプル:>
  
  # 最初のイメージソースを取得
  $data->{content} = <<'EOS';
<img class="ppp" src="/path">
  EOS
  $api->parse_first_img_src($data);
  my $img_src = $data->{img_src};

出力の「img_src」は「/path」です。

=head2 read_common_templates

  $api->read_common_templates($data);

「templates/common」ディレクトリの中の共通テンプレートを読み込みます。

次のテンプレートがロードされます。コンテンツはUTF-8からデコードされます。

「meta.html」「header.html」「footer.html」「side.html」「top.html」「bottom.html」

B<出力:>

  $data->{meta}
  $data->{header}
  $data->{footer}
  $data->{side}
  $data->{top}
  $data->{bottom}

=head2 add_meta_title

titleタグをmetaセクションに追加します。

B<入力:>

  $data->{title}
  $data->{meta}

B<出力:>

  $data->{meta}

「meta」の値が「foo」で「title」が「Perl Tutorial」だった場合は、「meta」の出力値は「foo\n<title>Perl Tutorial</title>」になります。

=head2 add_meta_description

meta descriptionタグをmetaセクションに追加します。

B<入力:>

  $data->{description}
  $data->{meta}

B<出力:>

  $data->{meta}

「meta」の値が「foo」で「description」が「Perl is good」の場合は, 「meta」の出力の値は、「foo\n<meta name="description" content="Perl is good">」になります。

=head2 build_entry

エントリのHTMLを「content」「top」「bottom」から作成します。

B<入力:>

  $data->{content}
  $data->{top}
  $data->{bottom}

B<出力:>

  $data->{content}

出力は、以下のHTMLです。

  <div class="entry">
    <div class="top">
      $data->{top}
    </div>
    <div class="middle">
      $data->{content}
    </div>
    <div class="bottom">
      $data->{bottom}
    </div>
  </div>

=head2 build_html

HTMLの全体を「content」「header」「bottom」「side」「footer」から作成します。

B<入力:>

  $data->{content}
  $data->{header}
  $data->{bottom}
  $data->{side}
  $data->{footer}

B<出力:>

  $data->{content}

出力は、以下のHTMLになります。

  <!DOCTYPE html>
  <html>
    <head>
      $data->{meta}
    </head>
    <body>
      <div class="container">
        <div class="header">
          $data->{header}
        </div>
        <div class="main">
          <div class="content">
            $data->{content}
          </div>
          <div class="side">
            $data->{side}
          </div>
        </div>
        <div class="footer">
          $data->{footer}
        </div>
      </div>
    </body>
  </html>

=head2 write_to_public_file

コンテンツ(content)を「public」ディレクトリの中のファイルに書き込みます。コンテンツはUTF-8にエンコードされます。

「file」の値が「index.html」であれば, 書き込まれるパスは「public/index.html」です。

B<入力:>

  $data->{content}
  $data->{file}

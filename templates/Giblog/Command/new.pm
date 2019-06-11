=encoding utf8

=head1 名前

Giblog::Command::new - 空のWebサイト作成コマンド

=head1 説明

L<Giblog::Command::new>は、空のWebサイトを作成するためのコマンドです。

L<Giblog::Command::new>を継承して、L<Giblog::Command::new_blog>やL<Giblog::Command::new_website>のような、オリジナルのWebサイト作成コマンドを作ることもできます。

=head1 メソッド

L<Giblog::Command::new>はL<Giblog::Command>からすべてのメソッドを継承しており、次の新しいメソッドを実装しています。

=head2 run

  $command->run($website_name);

Webサイト名を指定して、Webサイトを作成します。

すべてのコンテンツは、C<proto>ディレクトリからコピーされます。

もしモジュールがロードされたパスが"/path/Giblog/Command/new.pm"の場合は、C<proto>ディレクトリのパスは"/path/Giblog/Command/new/proto"になります。

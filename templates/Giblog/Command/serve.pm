=encoding utf8

=head1 名前

Giblog::Command::serve - Webサイトのサーブコマンド

=head1 説明

L<Giblog::Command::serve>はWebサイトをサーブするコマンドです。

=head1 メソッド

L<Giblog::Command::add>はL<Giblog::Command>からすべてのメソッドを継承しており、次の新しいメソッドを実装しています。

=head2 run

  $command->run;

L<Mojolicious>のL<morbo>コマンドを使って、C<serve.pl>でWebサイトサーブします。

以下のコマンドと同じです。

  morbo -w giblog.conf -w lib -w templates serve.pl

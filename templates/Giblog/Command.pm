=encoding utf8

=head1 名前

Giblog::Command - コマンド基底クラス

=head1 説明

L<Giblog::Command>は、コマンドの基底クラスです。

L<Giblog::Command>を継承して、L<Giblog::Command::new>、L<Giblog::Command::add>、L<Giblog::Command::build>のような、オリジナルのコマンドを作成できます。

=head1 メソッド

=head2 new

  $command->new(%args);

L<Giblog::Command>オブジェクトを生成します。

引数:

=over 2

=item * api

L<Giblog::API>オブジェクト

=back

=head2 api

  $command->api;

L<Giblog::API>オブジェクトを取得します。

=head2 run

  $command->run(@args);

コマンドを実行します。このメソッドは、サブクラスで実装されます。

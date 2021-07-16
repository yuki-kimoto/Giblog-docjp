=encoding utf8

=head1 名前

Giblog::Command::publish - Webサイトを公開するコマンド

=head1 説明

L<Giblog::Command::publish>はWebサイトを公開するコマンドです。

=head1 メソッド

L<Giblog::Command::add>はL<Giblog::Command>からすべてのメソッドを継承しており、次の新しいメソッドを実装しています。

=head2 run

  $command->run($remote_repository, $branch);

リモートレポジトリ名とブランチ名を指定して、Webサイトを公開します。

これは以下のコマンドと同じです。この例では、リポジトリ名はorigin、ブランチ名はmainです。YY-mm-dd HH:MM:SSは、現在の日付と時刻になります。

  git --git-dir=public/.git add --all
  git --git-dir=public/.git commit -m "Published by Giblog at YY-mm-dd HH:MM:SS"
  git --git-dir=public/.git push origin main

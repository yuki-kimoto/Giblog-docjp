use strict;
use warnings;
use utf8;

my @args = @ARGV;

my $deploy_cmd = q(ssh prod_perl_club_sites 'git -C ~/www/Giblog-docjp-public fetch && git -C ~/www/Giblog-docjp-public reset --hard origin/master');

system($deploy_cmd) == 0
  or die "Can't execute deploy command: $deploy_cmd:$!";

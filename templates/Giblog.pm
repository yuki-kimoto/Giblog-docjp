package Giblog;

use 5.008007;
use strict;
use warnings;

use Getopt::Long 'GetOptions';

our $VERSION = '0.70';

sub new {
  my $class = shift;
  
  my $self = {
    @_
  };
  
  return bless $self, $class;
}

sub home_dir { shift->{'home_dir'} }
sub config { shift->{config} }

sub build_api {
  my ($class, %opt) = @_;
  
  my $giblog = Giblog->new(%opt);

  my $api = Giblog::API->new(giblog => $giblog);
  
  return $api;
}

sub parse_argv {
  my ($class, @argv) = @_;
  
  # If first argument don't start with -, it is command
  my $command_name;
  if (@argv && $argv[0] !~ /^-/) {
    $command_name = shift @argv;
  }

  # Command
  unless (defined $command_name) {
    die "Command must be specifed\n";
  }
  if ($command_name =~ /^-/) {
    die "Command \"$command_name\" is not found\n";
  }
  
  local @ARGV = @argv;
  my $getopt_option_save = Getopt::Long::Configure(qw(default no_auto_abbrev no_ignore_case));
  GetOptions(
    "h|home=s" => \my $home_dir,
    'I|include=s'  => \my @include,
  );
  Getopt::Long::Configure($getopt_option_save);
  
  my $opt = {
    home_dir => $home_dir,
    include => \@include,
    command_name => $command_name,
    argv => \@argv
  };
  
  return $opt;
}

=head1 NAME

Giblog - HTML Generator for git generation

=head1 DESCRIPTION

Giblog is B<HTML generator> written by Perl language.

You can create B<your onw website and blog> easily.

Giblog is in beta test before 1.0 release. Note that features is changed without warnings.

=head1 SYNOPSYS
  
  # New empty web site
  giblog new mysite

  # New simple web site
  giblog new_website mysite

  # New simple blog
  giblog new_blog mysite
  
  # Change directory
  cd mysite
  
  # Add new entry
  giblog add

  # Build web site
  giblog build
  
  # Serve web site(need Mojolicious)
  morbo serve.pl

  # Add new entry with home directory
  giblog add --home /home/kimoto/mysite
  
  # Build web site with home directory
  giblog build --home /home/kimoto/mysite

=head1 DESCRIPTION

Giblog have the following features.

=over 4

=item * Build both website and blog.

=item * Linux, Mac OS, Windows Support. (In Windows, recommend installation of msys2)

=item * Default CSS for smart phone site

=item * Content is wrapped by top section, bottom section, header, footer, HTML head, and side var.

=item * Add p tag automatically. Escape E<lt>, E<gt> automatically in pre tag

=item * Set title tag automatically from text of first h1-h6 tag.

=item * Set meta description tag automatically from text of first p tag.

=item * You can use above all features or choice some of them, and can add more advanced features.

=item * In advanced features, you can customize list of entries page, use markdown syntax, and add twitter card, etc.

=item * Build 645 pages by 0.78 seconds in my starndard linux environment.

=item * Use JavaScript. Display the ad

=item * You can manage files by git easily, and deploy them to rental server.

=item * If you use Github Pages, you can create https web site for free.

=item * Giblog is used to build Perl Zemi web site.

=back

=head1 TUTORIAL

=head2 Create web site

You can create web site from 3 prototype.

B<1. Empty website>

"new" command create empty website. "mysite" is a exapmle name of your web site.

  giblog new mysite

If you want to create empty site, choice this prototype.

Templates and CSS is empty and provide minimal build process.

B<2. Website>

"new_website" command create empty website. 

  giblog new_website mysite

If you want to create simple website, choice this prototype.

Template of top page "templates/index.html" is created. CSS is designed to match smart phone site and provide basic build process.

B<3. Blog>

"new_blog" command create empty website. 

  giblog new_blog mysite

If you want to create blog, choice this prototype.

Have page "templates/index.html" which show 7 days entry.

Have page "templates/list.html" which show all page links.

CSS is designed to match smart phone site and provide basic build process.

=head2 Add entry page

"add" command add blog entry page.
  
  giblog add

You need to change directory to "mysite" before run "add" command.

  cd mysite

If you use "--home" option, you don't need to change directory

  giblog add --home /home/kimoto/mysite

Created file name is, for example,

  templates/blog/20080108132865.html

This file name contains current date and time.

=head2 Build web site

"build" command build web site.

  giblog build

You need to change directory to "mysite" before run "build" command.

  cd mysite

If you use "--home" option, you don't need to change directory.

  giblog build --home /home/kimoto/mysite

What is build process?

Build process is writen in "run" method of "lib/Giblog/Command/build.pm".

Main part of build process is combination of L<Giblog::API>.
  
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

"run" method read all template files in "templates" directory, and edit them, and wrtie output to file in "public" directory.

You can edit this build process by yourself if you need.

If you need to understand APIs in run method, see L<Giblog::API>.

=head2 Serve web site

If you have L<Mojolicious>, you can build and serve web site.

   morbo serve.pl

You see the following message.

   Server available at http://127.0.0.1:3000
   Server start

If files in "templates" directory is updated, web site is build and this server is reloaded automatically.

=head1 AUTHOR

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Yuki Kimoto.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

=cut

1;

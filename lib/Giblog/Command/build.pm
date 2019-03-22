package Giblog::Command::build;

use base 'Giblog::Command';

use strict;
use warnings;

use Pod::Simple::XHTML;

sub _indentation {
  (sort map {/^(\s+)/} @{shift()})[0];
}

sub run {
  my ($self, @args) = @_;
  
  # API
  my $api = $self->api;
  
  # Read config
  my $config = $api->read_config;
  
  # Get files in templates directory
  my $files = $api->get_templates_files;
  
  for my $file (@$files) {
    
    my $data = {file => $file};
    
    # Get content from file in templates directory
    $api->get_content($data);

    # Parse POD
    if ($data->{file} =~ /\.pm$/) {
      my $content = $data->{content};

      # Parse title
      parse_title($api, $data);

      # Parse description
      parse_description($api, $data);

      my $pod = $content;
      my $parser = Pod::Simple::XHTML->new;
      $parser->perldoc_url_prefix('https://metacpan.org/pod/');
      $parser->$_('') for qw(html_header html_footer);
      $parser->strip_verbatim_indent(\&_indentation);
      $parser->output_string(\(my $output));
      $parser->parse_string_document("$pod");
      
      $content = $output;
      
      $data->{content} = $content;

      # Fix extension
      $data->{file} =~ s/\.pm$/.html/;
      
      # Top page
      if ($data->{file} eq 'Giblog.html') {
        $data->{file} = 'index.html';
      }
    }
    # Parse Giblog syntax
    else {
      $api->parse_giblog_syntax($data);
    }

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
}

sub parse_title {
  my ($api, $data) = @_;
  
  my $content = $data->{content};
  my $title;
  if ($content =~ /=head1 NAME(.*?)=/s) {
    $title = $1;
    $title =~ s/^\s*//;
    $title =~ s/\s+$//;
  } 
  
  $data->{title} = $title;
}

sub parse_description {
  my ($api, $data) = @_;
  
  my $content = $data->{content};
  my $description;
  if ($content =~ /=head1 DESCRIPTION(.*?)=/s) {
    $description = $1;
    $description =~ s/^\s*//;
    $description =~ s/\s+$//;
    $description =~ s/B<//g;
    $description =~ s/>//g;
  } 
  
  $data->{description} = $description;
}

1;

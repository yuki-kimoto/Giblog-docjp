package Giblog::Command::build;

use base 'Giblog::Command';

use strict;
use warnings;
use utf8;

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
  
  # Copy static files to public
  $api->copy_static_files_to_public;

  # Get files in templates directory
  my $files = $api->get_templates_files;
  
  for my $file (@$files) {
    
    # CGI
    if ($file =~ /\.cgi$/) {
      
      # CGI content
      my $cgi_content;
      {
        # Data
        my $data = {file => $file};

        # Get content from file in templates directory
        $api->get_content($data);
        
        # CGI content
        $cgi_content = $data->{content};
      }
      
      # Data
      my $data = {file => $file};
      
      # Read common templates
      $api->read_common_templates($data);
      
      # Title(Replaced by CGI)
      $data->{title} = '$TITLE';
      
      # Add meta title
      $api->add_meta_title($data);
      
      # Content(Replaced by CGI)
      $data->{content} = '$CONTENT';
      
      # Build entry html
      $api->build_entry($data);
      
      # Build whole html
      $api->build_html($data);
      
      # Add html to CGI DATA section
      $data->{content} = "$cgi_content\n$data->{content}";
      
      # Write to public file
      $api->write_to_public_file($data);
      
      # Do executable
      chmod 0755, $api->rel_file("public/$file");
    }
    # HTML, etc
    else {
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
        $parser->$_('') for qw(html_header html_footer);
        $parser->strip_verbatim_indent(\&_indentation);
        $parser->output_string(\(my $output));
        $parser->parse_string_document("$pod");
        
        $content = $output;
        
        $content =~ s|\Qhttp://search.cpan.org/perldoc?\E([^"]+)|my $name = $1; $name =~ s!::!/!g; $name .= ".html"; "/$name";|ge;
        
        $data->{content} = $content;

        # Fix extension
        $data->{file} =~ s/\.pm$/.html/;
        $data->{file} =~ s/\.pod$/.html/;
        
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
}

sub parse_title {
  my ($api, $data) = @_;
  
  my $content = $data->{content};
  my $title;
  if ($content =~ /=head1 名前(.*?)=/s) {
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
  if ($content =~ /=head1 説明(.*?)=/s) {
    $description = $1;
    $description =~ s/^\s*//;
    $description =~ s/\s+$//;
    $description =~ s/B<//g;
    $description =~ s/>//g;
  } 
  
  $data->{description} = $description;
}

1;

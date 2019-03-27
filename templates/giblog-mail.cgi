#!/usr/bin/env perl

use strict;
use warnings;

use utf8;
use Encode 'decode', 'encode';
use MIME::Base64;

# Mail to
my $mailto = 'kimoto_yuki@shinshina.co.jp';

# Mail title
my $subject = 'Mail From giblog-mail';

# Mail command
my $mail_cmd = '/usr/sbin/sendmail';

# Title mail form
my $title_mail_form = 'Mail form';

# Content mail form
my $content_mail_form = <<"EOS";
<h2>Message Form</h2>
<form method="POST" action="" class="mail-form">
	<label>
		<div class="mail-form-title">
		  Name:
		</div>
		<div class="mail-form-body">
		  <input type="text" size=50 name="name"><br>
		</div>
  </label>
	<label>
		<div class="mail-form-title">
		  Mail:
		</div>
		<div class="mail-form-body">
		  <input type="text" size=50 name="email">
		</div>
  </label>
	<label>
		<div class="mail-form-title">
		  Message:
		</div>
		<div class="mail-form-body">
		  <textarea cols=50 rows=3 name="message"></textarea>
		</div>
  </label>
	<div>
	  <input type="submit" value="Send"> <input type="reset" value="Clear">
	</div>
</form>
EOS

# Title result
my $title_result = 'Thank you';

# Content result
my $content_result = <<"EOS";
<h2>Mail sending result</h2>
<div>
  <p>Thank you very much for contacting us.</p>
</div>
<div>
  <a href="/index.html">[Back]</a>
</div>
EOS

# GET request
if ($ENV{REQUEST_METHOD} eq "GET") {
  # Check CGI and mail command - giblog-mail.cgi?test
  if ($ENV{QUERY_STRING} =~ /test/) {
    my $message = <<"EOS";
Content-type: text/html; charset=UTF-8

<p>CGI : OK</p>
EOS

		if (-x $mail_cmd) {
			$message .= "<p>Mail Command : OK</p>";
		}
		else {
			$message .= "<p>Mail Command : Not OK</p>";
		}
    $message .= <<"EOS";
EOS
	  print encode('UTF-8', $message);
  }
  # Top page - giblog-mail.cgi
  else {
		$content_mail_form = build_html($title_mail_form, $content_mail_form);
    my $html = <<"EOS";
Content-type: text/html; charset=UTF-8

$content_mail_form
EOS
    
    # Output
	  print encode('UTF-8', $html);
  }
}
# POST request
elsif ($ENV{'REQUEST_METHOD'} eq "POST") {
	# Form data
	my %form;
	my @form_name_index;
	my $cnt = 0;
	
	read(STDIN, my $query_string, $ENV{'CONTENT_LENGTH'});
	my @pairs = split(/&/, $query_string);
	for my $x (@pairs) {
		my ($name, $value) = split(/=/, $x);
		$name =~ tr/+/ /;
		$name =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack("C", hex($1))/eg;
		$value =~ tr/+/ /;
		$value =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack("C", hex($1))/eg;
		$value =~ s/\r\n/\n/g;
		
		$name = decode('UTF-8', $name);
		$value = decode('UTF-8', $value);
		
		if (defined $form{$name}) {
			$form{$name} .= " " . $value;
		}
		else {
			$form{$name} = $value;
			$form_name_index[$cnt++] = $name;
		}
	}

	# Mail header
	my $mailfrom;
	if ($form{'email'} =~ /^[-_\.a-zA-Z0-9]+\@[-_\.a-zA-Z0-9]+$/) {
		$mailfrom = $form{'email'};
	}
	my $mail_head = "";
	$mail_head .= "Content-Type: text/plain; charset=\"UTF-8\"\n";
	$mail_head .= "Content-Transfer-Encoding: base64\n";
	$mail_head .= "MIME-Version: 1.0\n";
	$mail_head .= "To: $mailto\n";
	if ($mailfrom) {
		$mail_head .= "From: $form{'email'}\n";
		$mail_head .= "Cc: $form{'email'}\n";
	} else {
		$mail_head .= "From: $mailto\n";
	}
	$mail_head .= "Subject: " . encode('MIME-Header', $subject) . "\n";
	$mail_head .= "\n";

	# Mail body
	my $mail_body;
	for (my $i = 0; $i < $cnt; $i++) {
		$mail_body .= "$form_name_index[$i] = $form{$form_name_index[$i]}\n";
	}

	# Send mail
	my $cmd = "$mail_cmd -f $mailto -t";
	my $send_error;
	if (open(my $out, "| $cmd")) {
	  if (print $out $mail_head) {
			if (print $out encode_base64(encode('UTF-8', $mail_body))) {
			  # Success
			}
			else {
				$send_error = "Mail sending fail(3)";
			}
	  }
	  else {
	    $send_error = "Mail sending fail(2)";
	  }
	}
	else {
		$send_error = "Mail sending fail(1)";
	}
	
	if ($send_error) {
	  my $content = <<"EOS";
<h2>Error</h2>
<p>$send_error</p>
EOS
	  my $html = <<"EOS";
Content-type: text/html; charset=UTF-8

$content
EOS
    
    # Output
		print encode('UTF-8', $html);
	}
	else {
		# HTML
		$content_result = build_html($title_result, $content_result);
		my $html = <<"EOS";
Content-type: text/html; charset=UTF-8

$content_result
EOS
    
    # Output
		print encode('UTF-8', $html);
	}
}

sub build_html {
  my ($title, $content) = @_;
  
  local $/;
  my $html = <DATA>;
  
  $html =~ s/\$TITLE/$title/;
  $html =~ s/\$CONTENT/$content/;
  
  return $html;
}

__DATA__

<html>
  <head>
    <title>$TITLE</title>
    <style>
      body { background:red; }
    </style>
  </head>
  <body>
    $CONTENT
  </body>
</html>

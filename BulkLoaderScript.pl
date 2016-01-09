#!/usr/bin/perl
use LWP;
use LWP::UserAgent;
use Getopt::Std;
use strict;

use constant BASE_URL => 'https://post.craigslist.org/bulk-rss';

# process options
my $opts = {};
getopts('o:f:p', $opts);
my $post     = $opts->{'p'};
my $filename = $opts->{'f'};
my $outfile  = $opts->{'o'};
unless($filename) {
  print "usage: $0 [-p] [-o outfile] -f filename\n".
        "       options:\n".
        "       -f  -  the name of the RSS file to submit (required)\n".
        "       -p  -  actually post (otherwise just validate)\n".
        "       -o  -  output filename (otherwise results sent to STDOUT)\n\n";
  exit(0);
}

# open file
my $content = undef;
open(CFH, "<$filename") || die "can't open $filename for read: $!";
{ local $/ = undef; $content = <CFH>; }
close(CFH);

# prepare request
my $ua = LWP::UserAgent->new();
$ua->agent('SampleBulkPostClient/0.1');
my $post_url = BASE_URL .'/'. ($post? 'post': 'validate');
my $req = HTTP::Request->new( POST => $post_url );
$req->content_type('application/x-www-form-urlencoded');
$req->content($content);

# issue request
my $res = $ua->request($req);

# print result
if($res->is_success()) {
  if($outfile) {
    open(OFH,">$outfile") || die "can't open $outfile for write: $!";
    print OFH $res->content();
    close OFH;
  }
  else {
    print $res->content()."\n";
  }
}
else {
  print "request failed:\n".
        $res->status_line()."\n".$res->content()."\n";
}

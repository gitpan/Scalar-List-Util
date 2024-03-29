#!/usr/bin/perl -w

BEGIN {
    unless (-d 'blib') {
	chdir 't' if -d 't';
	@INC = '../lib';
	require Config; import Config;
	keys %Config; # Silence warning
	if ($Config{extensions} !~ /\bList\/Util\b/) {
	    print "1..0 # Skip: List::Util was not built\n";
	    exit 0;
	}
    }
}

use strict;
use Test::More tests => 12;
use Scalar::Util qw(looks_like_number);

foreach my $num (qw(1 -1 +1 1.0 +1.0 -1.0 -1.0e-12)) {
  ok(looks_like_number($num), "'$num'");
}

is(!!looks_like_number("Inf"),	    $] >= 5.006001,	'Inf');
is(!!looks_like_number("Infinity"), $] >= 5.008,	'Infinity');
is(!!looks_like_number("NaN"),	    $] >= 5.008,	'NaN');
is(!!looks_like_number("foo"),	    '',			'foo');
is(!!looks_like_number(undef),	    $] < 5.009002,	'undef');

# We should copy some of perl core tests like t/base/num.t here

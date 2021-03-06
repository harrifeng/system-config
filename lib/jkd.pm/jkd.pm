#!/usr/bin/env perl
package jkd;

use strict;
use v5.10.1; # for say and switch
use autodie qw(:all);
use IPC::System::Simple qw(run runx capture capturex $EXITVAL EXIT_ANY);
use Encode;
use utf8;

use JSON;

my $json = JSON->new->utf8->canonical->pretty;

use String::ShellQuote;

use strict;
use warnings;

use Carp;
use Exporter;
BEGIN { @jkd::ISA = 'Exporter' }

@jkd::EXPORT = qw(name2id name2key name2name name_exists select_args);

use feature 'signatures';
no warnings "experimental::signatures";

sub name2id($jkd_cmds, $name) {
    my $jsonArray =
        $json->decode(scalar capturex("cached-run", "-e", "scm_jira_url", "jkd", @$jkd_cmds));

    map {
        return $_->{id} if $_->{name} eq $name || ($_->{key} && $_->{key} eq $name);
    } @$jsonArray;
    return undef;
}

sub name2key($jkd_cmds, $name) {
    my $jsonArray =
        $json->decode(scalar capturex("cached-run", "-e", "scm_jira_url", "jkd", @$jkd_cmds));

    map {
        return $_->{key} if $_->{name} eq $name || ($_->{key} && $_->{key} eq $name);
    } @$jsonArray;
    return undef;
}

sub name2name($jkd_cmds, $name) {
    my $jsonArray =
        $json->decode(scalar capturex("cached-run", "-e", "scm_jira_url", "jkd", @$jkd_cmds));

    map {
        return $_->{name} if $_->{name} eq $name || ($_->{key} && $_->{key} eq $name);
    } @$jsonArray;
    return undef;
}

sub name_exists($jkd_cmds, $name) {
    my $jsonArray =
        $json->decode(scalar capturex("cached-run", "-e", "scm_jira_url", "jkd", @$jkd_cmds));
    map {
        return 1 if $_->{name} eq $name || ($_->{key} && $_->{key} eq $name);
    } @$jsonArray;
    return undef;
}

sub select_args(@) {
    ## start code-generator "^\\s *#\\s *"
    # generate-getopt -s perl -l -P p:prompt O:order-name i:init-input
    ## end code-generator
    ## start generated code
    use Getopt::Long;

    Getopt::Long::Configure("posix_default");

    local @ARGV = @_;

    my $init_input = "";
    my $order_name = "";
    my $prompt = "";

    my $handler_help = sub {
        print ;
        print "\n\n选项和参数：\n";
        printf "%6s", '-i, ';
        printf "%-24s", '--init-input=INIT-INPUT';
        if (length('--init-input=INIT-INPUT') > 24 and length() > 0) {
            print "\n";
            printf "%30s", "";
        }
        printf "%s", ;
        print "\n";
        printf "%6s", '-O, ';
        printf "%-24s", '--order-name=ORDER-NAME';
        if (length('--order-name=ORDER-NAME') > 24 and length() > 0) {
            print "\n";
            printf "%30s", "";
        }
        printf "%s", ;
        print "\n";
        printf "%6s", '-p, ';
        printf "%-24s", '--prompt=PROMPT';
        if (length('--prompt=PROMPT') > 24 and length() > 0) {
            print "\n";
            printf "%30s", "";
        }
        printf "%s", ;
        print "\n";

        exit(0);
    };

    GetOptions (
        'init-input|i=s' => \$init_input,
        'order-name|O=s' => \$order_name,
        'prompt|p=s' => \$prompt,
        'help|h!' => \&$handler_help,
        );


    ## end generated code

    my @command = (
        "select-args", "-p", "$prompt", "-i", "$init_input",
        "-O", "$order_name",
        @ARGV
        );

    my $command = join(" ", shell_quote(@command));
    my $res = decode_utf8 (qx($command));

    return $res;
}

1;
__END__

=head1 NAME

jkd - Perl extension for blah blah blah

=head1 SYNOPSIS

   use jkd;
   blah blah blah

=head1 DESCRIPTION

Stub documentation for jkd,

Blah blah blah.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Bao Haojun, E<lt>baohaojun@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020 by Bao Haojun

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.2 or,
at your option, any later version of Perl 5 you may have available.

=head1 BUGS

None reported... yet.

=cut

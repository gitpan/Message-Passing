package Message::Passing::Input::STDIN;
use Moose;
use AnyEvent;
use Try::Tiny;
use namespace::autoclean;

with 'Message::Passing::Role::Input';

sub BUILD {
    my $self = shift;
    my $r; $r = AnyEvent->io(fh => \*STDIN, poll => 'r', cb => sub {
        my $input = <STDIN>;
        return unless defined $input;
        chomp($input);
        my $data = try { $self->decode($input) }
            catch { warn $_ };
        return unless $data;
        $self->output_to->consume($data);
        $r;
    });
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Message::Passing::Input::STDIN - STDIN input

=head1 SYNOPSIS

    logstash --input STDIN --output STDOUT
    {"foo": "bar"}
    {"foo":"bar"}

=head1 DESCRIPTION

=head1 SEE ALSO

L<Message::Passing>

=head1 AUTHOR

Tomas (t0m) Doran <bobtfish@bobtfish.net>

=head1 SPONSORSHIP

This module exists due to the wonderful people at Suretec Systems Ltd.
<http://www.suretecsystems.com/> who sponsored it's development for its
VoIP division called SureVoIP <http://www.surevoip.co.uk/> for use with
the SureVoIP API - 
<http://www.surevoip.co.uk/support/wiki/api_documentation>

=head1 COPYRIGHT

Copyright Suretec Systems 2012.

Logstash (upon which many ideas for this project is based, but
which we do not reuse any code from) is copyright 2010 Jorden Sissel.

=head1 LICENSE

XX - TODO

=cut

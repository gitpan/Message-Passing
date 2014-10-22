package Message::Passing::Output::Callback;
use Moose;
use namespace::autoclean;

has cb => (
    isa => 'CodeRef',
    is => 'ro',
);

sub consume {
    my ($self, $msg) = @_;
    $self->cb->($msg);
}

with 'Message::Passing::Role::Output';

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Message::Passing::Output::Callback - Output to call back into your code

=head1 SYNOPSIS

    Message::Passing::Output::Callback->new(
        cb => sub {
            my $message = shift;
        },
    );

=head1 METHODS

=head2 consume ($msg)

Calls the callback with the message as it's first parameter

=head1 SEE ALSO

L<Message::Passing>

=head1 SPONSORSHIP

This module exists due to the wonderful people at Suretec Systems Ltd.
<http://www.suretecsystems.com/> who sponsored it's development for its
VoIP division called SureVoIP <http://www.surevoip.co.uk/> for use with
the SureVoIP API - 
<http://www.surevoip.co.uk/support/wiki/api_documentation>

=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Message::Passing>.

=cut

1;


package Message::Passing::Role::HasErrorChain;
use Moose::Role;
use Message::Passing::Output::STDERR;
use namespace::autoclean;

has error => (
    does => 'Message::Passing::Role::Output',
    is => 'ro',
    default => sub {
        Message::Passing::Output::STDERR->new;
    },
);

1;

=head1 NAME

Message::Passing::Role::HasErrorChain - A role for components which can report errors

=head1 SYNOPSIS

    # Note this is an example package, and does not really exist!
    package Message::Passing::Output::ErrorAllMessages;
    use Moose;
    use namespace::autoclean;
    
    with qw/
        Message::Passing::Role::Output
        Message::Passing::Role::HasErrorChain
    /;
    
    sub consume {
        my ($self, $message) = @_;
        $self->error->consume($message);
    }
    
=head1 DESCRIPTION

Some components can create an error stream in addition to a message stream.

=head1 SPONSORSHIP

This module exists due to the wonderful people at Suretec Systems Ltd.
<http://www.suretecsystems.com/> who sponsored its development for its
VoIP division called SureVoIP <http://www.surevoip.co.uk/> for use with
the SureVoIP API - 
<http://www.surevoip.co.uk/support/wiki/api_documentation>

=head1 AUTHOR, COPYRIGHT AND LICENSE

See L<Message::Passing>.

=cut

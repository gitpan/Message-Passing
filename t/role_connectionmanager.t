use strict;
use warnings;
use Test::More;

{
    package Connection::Subscriber;
    use Moose;
    use namespace::clean -except => 'meta';

    has am_connected => ( is => 'rw' );

    sub connected {
        shift->am_connected(1);
    }

    sub disconnected {
        shift->am_connected(0);
    }
}
{
    package Some::Shonky::Async::Code;
    use Moose;
    use namespace::clean -except => 'meta';

}

{
    package My::Connection::Wrapper;
    use Moose;
    use Scalar::Util qw/ weaken /;
    use namespace::clean -except => 'meta';

    with 'Message::Passing::Role::ConnectionManager';

    sub _build_connection {
        my $self = shift;
        weaken($self);
        my $client = Some::Shonky::Async::Code->new;
        # Real code now has something like:
        # $client->add_connect_callback(sub {
        #   $self->_set_connected(1);
        # });
        # instead we'll simulate that below..
        return $client;
    }
}

my $sub = Connection::Subscriber->new;
ok !exists($sub->{am_connected});

my $i = My::Connection::Wrapper->new;
ok $i;
ok $i->{connection};
isa_ok $i->{connection}, 'Some::Shonky::Async::Code';

$i->subscribe_to_connect($sub);
ok !exists($sub->{am_connected});

$i->_set_connected(1);
ok exists($sub->{am_connected});
ok $sub->{am_connected};
Scalar::Util::weaken($sub);

my $sub2 = Connection::Subscriber->new;
$i->subscribe_to_connect($sub2);
ok $sub2->{am_connected};

is_deeply $i->_connect_subscribers, [$sub2];
ok !$sub;

done_testing;


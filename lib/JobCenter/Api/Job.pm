package JobCenter::Api::Job;
use Mojo::Base 'Mojo::EventEmitter';

has [qw(cb job_id inargs lcb listenstring timeout tmr vtag wfname)];

sub update {
	my ($self, %attr) = @_;
	my ($k,$v);
	while (($k, $v) = each %attr) {
		$self->{$k} = $v;
	}
	return $self;
}

# clean up all (circular) references so that perl can do 
# the real destroying
sub delete {
	my $self = shift;
	%$self = ();
}

#sub DESTROY {
#	my $self = shift;
#	say 'destroying ', $self;
#}

1;

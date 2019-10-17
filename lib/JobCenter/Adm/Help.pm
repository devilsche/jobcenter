package JobCenter::Adm::Help;

use Mojo::Base 'JobCenter::Adm::Cmd';

sub do_cmd {
	my $self = shift;
	
	return $self->help() unless @_;
	
	my $more = shift;

	my $admcmd = $self->adm->load_cmd($more);

	unless ($admcmd) {
		say "no help available for $more";
		return 0;
	}
		
	my $help = $admcmd->can('help');
	
	unless ($help) {
		say "command $more has no help available";
		return 0;
	}

	return $help->(@_);
}


sub help {
	print <<'EOT';

Usage: jcadm [opts] <cmd> ...

Subcomands:

clients                     : prints connected api clients
jobs [-v] [states]          : prints things about jobs
errors [-v] [workflows]     : prints things about job errors
help                        : this help
pending                     : prints api pending flags
workers                     : prints worker status from the db

Use 'jcadm <cmd> help' for more information about a subcommand.

Supported options:
	--config=/path/to/cfg   : use alternate configfile
	--debug=1               : set debug flag
	-h, -?, --help          : prints "try jcadm help"

EOT
	return 0;
}

1;


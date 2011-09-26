package Dist::Zilla::PluginBundle::LEONT::XS;
use Moose;
use Dist::Zilla;
with 'Dist::Zilla::Role::PluginBundle::Easy';

has use_modern => (
	is => 'ro',
	isa => 'Bool',
	default => 0,
);

sub configure {
	my $self = shift;

	$self->add_bundle('@Filter' => {
		-bundle => '@Basic',
		-remove => ['MakeMaker'],
	});
	$self->add_plugins('ModuleBuild');
	$self->add_bundle('@LEONT::Base');
	return;
}

1;

__END__

#ABSTRACT: Plugins LeonT uses for XS modules

=head1 DESCRIPTION

This is currently identical to the following setup:

    [@Filter]
    -bundle = @Basic
    -remove = MakeMaker
    [ModuleBuild]
    [@LEONT::Base]

=begin Pod::Coverage

configure

=end Pod::Coverage

=cut

1;

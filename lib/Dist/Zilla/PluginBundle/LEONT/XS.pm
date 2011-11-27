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
	if ($self->payload->{use_custom}) {
		$self->add_plugins('ModuleBuild::Custom');
		$self->add_plugins('Meta::Dynamic::Config');
	}
	else {
		$self->add_plugins('ModuleBuild');
	}
	$self->add_bundle('@LEONT::Base', $self->config_slice('skip_kwalitee'));
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

Unless the C<use_custom> option is set in dist.ini, in which case it's equal to 

    [@Filter]
    -bundle = @Basic
    -remove = MakeMaker
    [ModuleBuild::Custom]
    [Meta::Dynamic::Config]
    [@LEONT::Base]

=begin Pod::Coverage

configure

=end Pod::Coverage

=cut


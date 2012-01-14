package Dist::Zilla::PluginBundle::LEONT::XS;
use Moose;
use Dist::Zilla;
extends 'Dist::Zilla::PluginBundle::LEONT::Base';
with qw/Dist::Zilla::Role::PluginBundle::Easy Dist::Zilla::Role::PluginBundle::PluginRemover Dist::Zilla::Role::PluginBundle::Config::Slicer/;

has use_modern => (
	is => 'ro',
	isa => 'Bool',
	default => 0,
);

my @basic = qw/GatherDir PruneCruft ManifestSkip MetaYAML License Readme ExtraTests ExecDir ShareDir Manifest TestRelease ConfirmRelease UploadToCPAN/; # left out MakeMaker

sub configure {
	my $self = shift;

	$self->add_plugins(@basic);

	if ($self->payload->{use_custom}) {
		$self->add_plugins('ModuleBuild::Custom');
		$self->add_plugins('Meta::Dynamic::Config');
	}
	else {
		$self->add_plugins('ModuleBuild');
	}
	$self->SUPER::configure;
	return;
}

1;

#ABSTRACT: Plugins LeonT uses for XS modules

__END__

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


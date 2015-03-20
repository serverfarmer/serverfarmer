#! /usr/bin/perl

# this script requires the following CPAN packages:
#   YAML
#   ExtUtils::MakeMaker
#   Inline::MakeMaker
#   Device::USB
#   Device::USB::PCSensor::HidTEMPer

use 5.010;
use strict;
use warnings;
use Carp;
use Device::USB;
use Device::USB::PCSensor::HidTEMPer::Device;
use Device::USB::PCSensor::HidTEMPer::NTC;
use Device::USB::PCSensor::HidTEMPer::TEMPer; 
use lib;
use Device::USB::PCSensor::HidTEMPer;

my $pcsensor = Device::USB::PCSensor::HidTEMPer->new();
my @devices  = $pcsensor->list_devices();

foreach my $device ( @devices )
{
	my $identifier   = $device->identifier();
	my $raw_internal = 100;
	my $raw_external = 100;

	while ( $raw_internal > 55 ) {
		$raw_internal = $device->internal()->celsius();
	}

	while ( $raw_external > 55 ) {
		$raw_external = $device->external()->celsius();
	}

	my $internal = substr $raw_internal, 0, 5;
	my $external = substr $raw_external, 0, 5;

	printf "id:$identifier internal:$internal external:$external\n";
}


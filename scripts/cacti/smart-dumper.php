#!/usr/bin/php5
<?php
// skrypt do odczytu atrybutów S.M.A.R.T. z podłączonych dysków, wersja 2
// Tomasz Klim, lipiec 2012



// tych urządzeń nie monitorujemy
$exceptions = array (
	"VBOX_HARDDISK",  // dysk wirtualny
	"CF_CARD",  // nie interesuje nas stan kart CF
	"-part",  // to jest partycja dysku, a nie sam dysk
);


function list_devices( $dirname, $mask )
{
	$files = array();
	$handle = @opendir( $dirname );

	if ( $handle === false )
		return false;

	while ( false !== ($file = @readdir($handle)) )
		if ( $file != "." && $file != ".." && preg_match($mask, $file) )
			$files[] = "$dirname/$file";

	closedir( $handle );
	return $files;
}


$force = ( isset($argv[1]) && $argv[1] === "--force" );

// ls /dev/disk/by-id/ata-* |grep -v -- -part |grep -v VBOX_HARDDISK |grep -v CF_CARD
$drive_partitions = list_devices( "/dev/disk/by-id", "/ata-[a-zA-Z0-9_-]+$/" );

$data = file_get_contents("/opt/farm/common/standby.conf");
$lines = explode("\n", $data);
$skip_devices = array();

foreach ( $lines as $line )
{
	$line = trim( $line );

	if ( !empty($line) && strpos($line, "#") !== 0 )
		$skip_devices[] = $line;
}

foreach ( $drive_partitions as $id )
{
	$found = false;
	foreach ( $exceptions as $exception )
		if ( strpos($id, $exception) !== false )
			$found = true;

	if ( !$found ) {
		$device = basename( $id );

		if ( !in_array($device, $skip_devices, true) || $force ) {
			$report = shell_exec( "/usr/sbin/smartctl -d sat -T permissive -a $id" );

			$file = "/var/cache/cacti/$device.txt";
			file_put_contents( $file, trim($report) );

			$ret = shell_exec( "/opt/farm/scripts/cacti/send.sh $file 2>&1" );
			$ret = trim( $ret );

			if ( !empty($ret) && $ret != "lost connection" ) {
				echo "error: $ret\n";
			}
		}
	}
}


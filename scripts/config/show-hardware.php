#!/usr/bin/php5
<?php
// skrypt wyświetlający konfigurację bieżącego komputera
// Tomasz Klim, maj 2011, maj 2015


function get_hostname()
{
	static $host = false;
	if ( $host === false ) {

		if ( function_exists("posix_uname") ) {
			$uname = posix_uname();
			$host = $uname["nodename"];

		} else if ( file_exists("/etc/farmconfig") ) {
			$lines = file("/etc/farmconfig");
			foreach ($lines as $line) {
				$tmp = explode("=", $line);
				if ($tmp[0] == "HOST") {
					$host = trim($tmp[1]);
					break;
				}
			}
			if ($host === false)
				$host = "localhost";

		} else if ( file_exists("/etc/hostname") ) {
			$host = file_get_contents("/etc/hostname");
			$host = trim($host);
		} else if ( file_exists("/etc/HOSTNAME") ) {
			$host = file_get_contents("/etc/HOSTNAME");
			$host = trim($host);
		} else {
			$host = "localhost";
		}
	}
	return $host;
}

function get_ip( $hostname )
{
	return gethostbyname( $hostname );
}


function parse_dmi()
{
	if ( file_exists("/sys/class/dmi/id") )
		$dmi = "/sys/class/dmi/id";
	else if ( file_exists("/sys/devices/virtual/dmi/id") )
		$dmi = "/sys/devices/virtual/dmi/id";
	else
		return array();

	$vendor = @file_get_contents( "$dmi/sys_vendor" );
	$product = @file_get_contents( "$dmi/product_name" );

	$product_serial = @file_get_contents( "$dmi/product_serial" );
	$chassis_serial = @file_get_contents( "$dmi/chassis_serial" );
	$board_serial = @file_get_contents( "$dmi/board_serial" );
	$board_name = @file_get_contents( "$dmi/board_name" );

	$bios_version = @file_get_contents( "$dmi/bios_version" );
	$bios_date = @file_get_contents( "$dmi/bios_date" );

	return array (
		"vendor" => trim($vendor),
		"product_name" => trim($product),
		"product_serial" => trim($product_serial),
		"chassis_serial" => trim($chassis_serial),
		"board_serial" => trim($board_serial),
		"board_name" => trim($board_name),
		"bios_version" => trim($bios_version),
		"bios_date" => trim($bios_date),
	);
}

function parse_cpuinfo()
{
	$params = array( "model name", "cache size", "Processor", "Hardware" );  // last 2 from QNAP
	$lines = file( "/proc/cpuinfo" );
	$out = array();

	foreach ( $lines as $line ) {
		$parts = explode( ":", $line );
		$param = trim( $parts[0] );
		$value = trim( @$parts[1] );

		if ( in_array($param, $params, true) )
			$out[$param][] = $value;
	}

	return $out;
}

function parse_meminfo()
{
	$params = array( "MemTotal" );
	$lines = file( "/proc/meminfo" );
	$out = array();

	foreach ( $lines as $line ) {
		$parts = explode( ":", $line );
		$param = trim( $parts[0] );
		$value = trim( @$parts[1] );

		if ( in_array($param, $params, true) )
			$out[$param] = $value;
	}

	return $out;
}

function parse_swaps()
{
	$lines = file( "/proc/swaps" );
	$out = array();

	foreach ( $lines as $line ) {
		$line = str_replace( "\t", " ", $line );
		$parts = preg_split( "/ /", $line, -1, PREG_SPLIT_NO_EMPTY );

		$mount = trim( $parts[0] );
		$size = trim( $parts[2] );

		if ( $mount != "Filename" )
			$out[$mount] = $size;
	}

	return $out;
}


function print_cpu( $cpu, $dmi )
{
	echo "Host CPU:\n";
	if ( isset($cpu["model name"]) ) {
		foreach ( $cpu["model name"] as $index => $name ) {
			if ( isset($cpu["cache size"]) ) {
				$cache = $cpu["cache size"][$index];
				echo "\tCPU $index: $name [cache $cache]\n";
			} else {
				echo "\tCPU $index: $name\n";
			}
		}
		$cnt = count( $cpu["model name"] );
		echo "\t($cnt logical processors)\n";
	} else {
		$processor = $cpu["Processor"][0];
		$hardware = $cpu["Hardware"][0];
		echo "\t$processor [$hardware]\n";
	}
	if ( isset($dmi["bios_version"]) ) {
		$ver = $dmi["bios_version"];
		$date = $dmi["bios_date"];
		echo "\tBIOS version $ver (released $date)\n";
	}
	echo "\n";
}

function print_memory( $mem, $swap )
{
	$phys = $mem["MemTotal"];
	echo "Host memory:\n";
	echo "\t$phys of physical memory\n";
	foreach ( $swap as $mount => $size ) {
		$type = ( strpos($mount, "/dev/loop") !== false || strpos($mount, "/dev/dm-") !== false ? "encrypted swap" : "swap" );
		echo "\t$size kB of $type at $mount\n";
	}
	echo "\n";
}

function print_info( $hostname, $ip, $dmi )
{
	echo "Host info:\n";
	echo "\t$hostname [IP: $ip]\n";
	$psk = "/proc/sys/kernel";
	if ( file_exists("$psk/ostype") ) {
		$type = trim( file_get_contents("$psk/ostype") );
		$rel = trim( file_get_contents("$psk/osrelease") );
		$ver = trim( file_get_contents("$psk/version") );
		echo "\t$type $rel $ver\n";
	}
	if ( isset($dmi["product_name"]) ) {
		$product = $dmi["product_name"];
		$vendor = $dmi["vendor"];
		echo "\t$product by $vendor\n";
	}
	echo "\n";
}



$hostname = get_hostname();
$ip = get_ip( $hostname );
$dmi = parse_dmi();
print_info( $hostname, $ip, $dmi );

$cpu = parse_cpuinfo();
print_cpu( $cpu, $dmi );

$mem = parse_meminfo();
$swap = parse_swaps();
print_memory( $mem, $swap );


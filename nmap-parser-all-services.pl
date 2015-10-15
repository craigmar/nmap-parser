#!/usr/bin/perl 
#written by craig marshall
#usage
#parser.pl <xml_nmap_file> <owner> <outputfile>

use Nmap::Parser;
my $np = new Nmap::Parser;
my $owner = $ARGV[1];
my $outfile = $ARGV[2] or die "Need an output file!";
open(OUTPUT, '>>' ,$outfile) or die "Could not open '$file' $!\n";
 
 $np->callback( \&parsexml );
 
 $np->parsefile($ARGV[0]);
    # or use parsescan()

 sub parsexml {
    my $host = shift; #Nmap::Parser::Host object, just parsed
    $ip =  $host->addr;
    if($host->hostname){
      $dns = $host->hostname
    }else{
     $dns= 'none';
    }
    @openports = $host->tcp_open_ports;
    foreach(@openports){
    $port = $_;
    $service = $host->tcp_service($port);
    $servtype = $service->name;
    $banner = $service->product;
    if($service->tunnel eq 'ssl'){
    $ssl = 'y';
    }else{
    $ssl = 'n';
    }
  
          print $ip . "," . $port . "," . $ssl . "," . $owner . "," . $banner. "," . $servtype . "," . $dns. "\n";
          print OUTPUT $ip . "," . $port . "," . $ssl . "," . $owner . "," . $banner. "," . $servtype . "," . $dns. "\n";
    
    }   
 }

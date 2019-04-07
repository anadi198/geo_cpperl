#!/usr/bin/env perl

use LWP::Simple;
use lib "../lib/";
use GeoIP2::Database::Reader; 

  sub get_city
  {  
    my $ip = get('https://checkip.amazonaws.com');
    chomp $ip;
    my $reader = GeoIP2::Database::Reader->new(
        file    => '../lib/GeoLite2-City.mmdb'
    );
 
    my $city = $reader->city( ip => $ip );
    my $city_rec = $city->city();
    $city_rec->name(); #implicitly return city name to caller of subroutine.
  }

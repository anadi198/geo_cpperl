package GeoIP2::Record::City;

use strict;
use warnings;

our $VERSION = '2.006001';

use Moo;

use GeoIP2::Types qw( NonNegativeInt PositiveInt Str );

use namespace::clean -except => 'meta';

with 'GeoIP2::Role::Record::HasNames';

has confidence => (
    is        => 'ro',
    isa       => NonNegativeInt,
    predicate => 'has_confidence',
);

has geoname_id => (
    is        => 'ro',
    isa       => PositiveInt,
    predicate => 'has_geoname_id',
);

1;

# ABSTRACT: Contains data for the city record associated with an IP address

__END__

=pod

=encoding UTF-8

=head1 NAME

GeoIP2::Record::City - Contains data for the city record associated with an IP address

=head1 VERSION

version 2.006001

=head1 SYNOPSIS

  use 5.008;

  use GeoIP2::WebService::Client;

  my $client = GeoIP2::WebService::Client->new(
      account_id  => 42,
      license_key => 'abcdef123456',
  );

  my $insights = $client->insights( ip => '24.24.24.24' );

  my $city_rec = $insights->city();
  print $city_rec->name(), "\n";

=head1 DESCRIPTION

This class contains the city-level data associated with an IP address.

This record is returned by all the end points except the Country end point.

=head1 METHODS

This class provides the following methods:

=head2 $city_rec->confidence()

This returns a value from 0-100 indicating MaxMind's confidence that the city
is correct.

This attribute is only available from the Insights end point and the GeoIP2
Enterprise database.

=head2 $city_rec->geoname_id()

This returns a C<geoname_id> for the city.

This attribute is returned by all end points.

=head2 $city_rec->name()

This returns a name for the city. The locale chosen depends on the C<locales>
argument that was passed to the record's constructor. This will be passed
through from the L<GeoIP2::WebService::Client> object you used to fetch the
data that populated this record.

If the record does not have a name in any of the locales you asked for, this
method returns C<undef>.

This attribute is returned by all end points.

=head2 $city_rec->names()

This returns a hash reference where the keys are locale codes and the values
are names. See L<GeoIP2::WebService::Client> for a list of the possible
locale codes.

This attribute is returned by all end points.

=head1 SUPPORT

Bugs may be submitted through L<https://github.com/maxmind/GeoIP2-perl/issues>.

=head1 AUTHORS

=over 4

=item *

Dave Rolsky <drolsky@maxmind.com>

=item *

Greg Oschwald <goschwald@maxmind.com>

=item *

Mark Fowler <mfowler@maxmind.com>

=item *

Olaf Alders <oalders@maxmind.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 - 2018 by MaxMind, Inc.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

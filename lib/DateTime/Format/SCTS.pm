package DateTime::Format::SCTS;

=head1 NAME

DateTime::Format::SCTS - parse Service Centre time-stamp DDMMYYhhmmss format

=head1 SYNOPSIS

  use DateTime::Format::SCTS;
  my $dt = DateTime::Format::SCTS->parse_datetime('030212065530');
  print $dt->ymd; # 2012-02-03
  print $dt->hms; # 06:55:30

=for readme stop

=cut

use 5.006;

our $VERSION = '0.01';

use strict;
use warnings;

use DateTime::Format::Builder (
    parsers => {
        parse_datetime => [
            {
                params => [qw( day month year hour minute second )],
                regex  => qr/^(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)$/,
                postprocess => \&_fix_year,
            }
        ]
    }
);

sub _fix_year {
    my %args = @_;
    my ($date, $p) = @args{qw( input parsed )};
    $p->{year} += $p->{year} > 69 ? 1900 : 2000;
    return 1;
};

sub format_datetime {
    my ($self, $dt) = @_;
    return sprintf '%02d%02d%02d%02d%02d%02d',
        $dt->day, $dt->month, $dt->year % 100,
        $dt->hour, $dt->minute, $dt->second;
};

1;

__END__

=for readme continue

=head1 PREREQUISITES

=over 2

=item *

L<DateTime::Format::Builder>

=back

=head1 SEE ALSO

L<http://github.com/dex4er/perl-DateTime-Format-SCTS>, L<DateTime>.

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (c) 2012 Piotr Roszatycki <dexter@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

See L<http://dev.perl.org/licenses/artistic.html>

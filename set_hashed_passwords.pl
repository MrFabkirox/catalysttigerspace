#!/usr/bin/perl

use strict;
use warnings;

use catalysttigerspace::Schema;

my $schema = catalysttigerspace::Schema->connect('dbi:SQLite:catalysttigerspace.db');

my @users = $schema->resultset('User')->all;

foreach my $user (@users) {
$user->password('mypass');
$user->update;
}

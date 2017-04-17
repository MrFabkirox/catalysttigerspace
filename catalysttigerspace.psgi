use strict;
use warnings;

use catalysttigerspace;

my $app = catalysttigerspace->apply_default_middlewares(catalysttigerspace->psgi_app);
$app;


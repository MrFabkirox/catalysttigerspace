use strict;
use warnings;
use Test::More;


use Catalyst::Test 'catalysttigerspace';
use catalysttigerspace::Controller::Busy;

ok( request('/busy')->is_success, 'Request should succeed' );
done_testing();

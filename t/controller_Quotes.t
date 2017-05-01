use strict;
use warnings;
use Test::More;


use Catalyst::Test 'catalysttigerspace';
use catalysttigerspace::Controller::Quotes;

ok( request('/quotes')->is_success, 'Request should succeed' );
done_testing();

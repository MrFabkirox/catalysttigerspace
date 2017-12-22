use strict;
use warnings;
use Test::More;


use Catalyst::Test 'catalysttigerspace';
use catalysttigerspace::Controller::model1;

ok( request('/model1')->is_success, 'Request should succeed' );
done_testing();

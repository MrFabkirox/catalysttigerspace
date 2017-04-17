use strict;
use warnings;
use Test::More;


use Catalyst::Test 'catalysttigerspace';
use catalysttigerspace::Controller::Books;

ok( request('/books')->is_success, 'Request should succeed' );
done_testing();

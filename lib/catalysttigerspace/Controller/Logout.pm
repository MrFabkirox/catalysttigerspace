package catalysttigerspace::Controller::Logout;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

catalysttigerspace::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched catalysttigerspace::Controller::Logout in Logout.');
}



=encoding utf8

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

=head2 index

Logout logic

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    # Clear the user's state
    $c->logout;

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
}

1;

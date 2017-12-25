package catalysttigerspace::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }


__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

catalysttigerspace::Controller::Root - Root Controller for catalysttigerspace

=head1 DESCRIPTION

Recreational Tiger Space

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $time = localtime(time);
  print("___________ $time __________index \n");

  $c->stash(template => 'index.tt2');
}

=head2 catalystindex

The root page (/catalystindex)

=cut

sub catalystindex :Path(/catalystindex) :Args(0) {
  my ( $self, $c ) = @_;

  my $time = localtime(time);
  print("___________ $time __________catalystindex \n");

  # Hello World
  $c->response->body( $c->welcome_message );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;

    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 auto

Check if there is a user and, if not, forward to login page

=cut

sub auto :Private {
    my ($self, $c) = @_;

    # Allow unauthenticated users to reach the login page.  This
    # allows unauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the 'index' action we
    # added above.
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    # If a user doesn't exist, force login
    if (!$c->user_exists) {
        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User not found, forwarding to /login');
        # Redirect the user to the login page
        # $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 1;
    }

    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

=head2 error_noperms

Permissions error screen

=cut

sub error_noperms :Chained('/') :PathPart('error_noperms') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'error_noperms.tt2');
}

1;

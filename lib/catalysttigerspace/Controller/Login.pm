package catalysttigerspace::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

catalysttigerspace::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=encoding utf8

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify

=cut

__PACKAGE__->meta->make_immutable;

=head2 index

Login logic

=cut

sub index :Path :Args(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("___________ $time __________login \n");

  my $username = $c->request->params->{username};
  my $password = $c->request->params->{password};

  # If the username and password values were found in form
  if ($username && $password) {

    if ($c->authenticate({ username => $username,
      password => $password  } )) {
        # If successful, then let them use the application
        $c->response->redirect($c->uri_for(
          $c->controller('Books')->action_for('list')));
          return;
    } else {
      $c->stash(error_msg => "Bad username or password.");
    }
  } else {
    # Set an error message
    $c->stash(error_msg => "Empty username or password.")
      unless ($c->user_exists);
  }

  # If either of above don't work out, send to the login page
  $c->stash(template => 'login.tt2');
}

1;

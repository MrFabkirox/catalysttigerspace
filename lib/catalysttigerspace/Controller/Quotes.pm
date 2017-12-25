package catalysttigerspace::Controller::Quotes;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

catalysttigerspace::Controller::Quotes - Catalyst Controller

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

=head2 quotes

=cut

sub quotes :Chained('/') :PathPart('quotes') :CaptureArgs(0) {
  my ( $self, $c ) = @_;

  my $time = localtime(time);
  print("___________ $time __________quotes \n");

  $c->log->debug('_____________ base ______________');
}

=head2 quote_list

=cut

sub quote_list :Chained('quotes') :PathPart('quote_list') :Args(0) {
  my ( $self, $c ) = @_;

  my $toto = '$toto';
  $c->stash($toto => '$toto');

  $c->stash->{message}  = 'stash message [.]';

  $c->log->debug('________ quote_list________');
  $c->stash(template => 'quotes/quote_list.tt2');

  }
1;

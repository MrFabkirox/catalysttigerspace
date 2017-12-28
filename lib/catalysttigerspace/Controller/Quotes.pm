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


=head2 quotes

=cut

sub quotes :Chained('/') :PathPart('quotes') :CaptureArgs(0) {
  my ( $self, $c ) = @_;

  my $time = localtime(time);
  print("____ $time ____quotes \n");

#  $c->stash(resultset => $c->model('DB::Book'));

  $c->log->debug('____ base ____');
}

=head2 quote_list

=cut

sub quote_list :Chained('quotes') :PathPart('quote_list') :Args(0) {
  my ( $self, $c ) = @_;

  my $time = localtime(time);
  print("____ $time ____quote_list \n");

  my $toto = '$toto';
  # $c->stash($toto => '$toto');

  # $c->stash(resultset => $c->model('DB::Quote'));
  # $c->stash(quotes => '');

  $c->stash(quotes => [$c->model('DB::Quote')->all]);
  $c->stash(from => [$c->model('DB::QuoteFrom')->all]);
  $c->stash(by => [$c->model('DB::QuoteBy')->all]);
  # $c->stash->{message}  = 'stash message [1]';

  # $c->log->debug('____ quote_list ____');
  $c->stash(template => 'quotes/quote_list.tt2');

  }

=encoding utf8

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify

=cut

__PACKAGE__->meta->make_immutable;

1;

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


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->log->debug('__________________ quote index __________________');
    $c->response->body('Matched catalysttigerspace::Controller::Quotes in Quotes.');
}



=encoding utf8

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

=head2 quotes

=cut

sub quotes :Chained('/') :PathPart('quotes') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->log->debug('__________________ base __________________');
}

=head2 quote_list

=cut

sub quote_list :Chained('quotes') :PathPart('quote_list') :Args(0) {
    my ( $self, $c ) = @_;
my $toto = '$toto';
    $c->stash($toto => '$toto');

    $c->stash->{message}  = 'Hello World!';

    $c->log->debug('________ quote_list s________');
    $c->stash(template => 'quotes/quote_list.tt2');
}
1;

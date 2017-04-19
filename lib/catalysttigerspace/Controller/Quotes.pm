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

=head2 quote_list

=cut

sub quotes :Chained('/') :PathPart('quotes') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    $c->log->debug('__________________ base __________________');
}

=cut

__PACKAGE__->meta->make_immutable;

=head2 quote_list

=cut

sub quotes_list :Chained('quotes') :PathPart('quotes_list') :Args(0) {
    my ( $self, $c ) = @_;

    $c->log->debug('__________________ quote_list __________________');
    $c->stash(template => 'quotes/quotes.tt2');
}
1;

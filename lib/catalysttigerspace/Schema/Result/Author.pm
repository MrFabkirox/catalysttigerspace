use utf8;
package catalysttigerspace::Schema::Result::Author;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

catalysttigerspace::Schema::Result::Author

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<author>

=cut

__PACKAGE__->table("author");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "first_name",
  { data_type => "text", is_nullable => 1 },
  "last_name",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 book_authors

Type: has_many

Related object: L<catalysttigerspace::Schema::Result::BookAuthor>

=cut

__PACKAGE__->has_many(
  "book_authors",
  "catalysttigerspace::Schema::Result::BookAuthor",
  { "foreign.author_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 books

Type: many_to_many

Composing rels: L</book_authors> -> book

=cut

__PACKAGE__->many_to_many("books", "book_authors", "book");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-17 14:09:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g981xVQ9a2KjpxOBWKst2A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;

# many_to_many():
#   args:
#     1) Name of relationship bridge, DBIC will create accessor with this name
#     2) Name of has_many() relationship this many_to_many() is shortcut for
#     3) Name of belongs_to() relationship in model class of has_many() above
#   You must already have the has_many() defined to use a many_to_many().
__PACKAGE__->many_to_many(books => 'book_authors', 'book');

#
# Row-level helper methods
#
sub full_name {
    my ($self) = @_;

    return $self->first_name . ' ' . $self->last_name;
}

1;

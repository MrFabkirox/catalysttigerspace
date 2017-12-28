use utf8;
package catalysttigerspace::Schema::Result::QuoteSayingFromBy;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

catalysttigerspace::Schema::Result::QuoteSayingFromBy

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

=head1 TABLE: C<quote_saying_from_by>

=cut

__PACKAGE__->table("quote_saying_from_by");

=head1 ACCESSORS

=head2 quote_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 from_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 by_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "quote_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "from_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "by_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</quote_id>

=item * L</from_id>

=item * L</by_id>

=back

=cut

__PACKAGE__->set_primary_key("quote_id", "from_id", "by_id");

=head1 RELATIONS

=head2 by

Type: belongs_to

Related object: L<catalysttigerspace::Schema::Result::QuoteBy>

=cut

__PACKAGE__->belongs_to(
  "by",
  "catalysttigerspace::Schema::Result::QuoteBy",
  { id => "by_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 from

Type: belongs_to

Related object: L<catalysttigerspace::Schema::Result::QuoteFrom>

=cut

__PACKAGE__->belongs_to(
  "from",
  "catalysttigerspace::Schema::Result::QuoteFrom",
  { id => "from_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 quote

Type: belongs_to

Related object: L<catalysttigerspace::Schema::Result::Quote>

=cut

__PACKAGE__->belongs_to(
  "quote",
  "catalysttigerspace::Schema::Result::Quote",
  { id => "quote_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-12-28 22:31:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:be0jPkmtjmTH7myJCdSrKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

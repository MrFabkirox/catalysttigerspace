package catalysttigerspace::Controller::Books;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

catalysttigerspace::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->log->debug('____ INSIDE INDEX METHOD ____');
  $c->response->body('catalysttigerspace::Controller::Books');
}

=head2 base

Can place common logic to start chained dispatch here

=cut

sub base :Chained('/') :PathPart('books') :CaptureArgs(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("____ $time ____base \n");

  # Store the ResultSet in stash so it's available for other methods
  $c->stash(resultset => $c->model('DB::Book'));

  # Print a message to the debug log
  $c->log->debug('____ INSIDE BASE METHOD ____');
}

=head2 book_list

Fetch all book objects and pass to books/book_list.tt2 in stash to be displayed

=cut

sub book_list :Chained('base') :PathPart('book_list') :Args(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("___________ $time __________book_list \n");

#  $c->stash(books => '');
#  $c->model('DB::Book')->search({}, {order_by => 'title DESC'});
  $c->stash(books => [$c->model('DB::Book')->all]);

  $c->stash(template => 'books/book_list.tt2');
}

=head2 object

Fetch the specified book object based on the book ID and store
it in the stash

=cut

sub object :Chained('base') :PathPart('id') :CaptureArgs(1) {
  # $id = primary key of book to delete
  my ($self, $c, $id) = @_;

  # Find the book object and store it in the stash
  $c->stash(object => $c->stash->{resultset}->find($id));

  # Make sure the lookup was successful.  You would probably
  # want to do something like this in a real app:
  #   $c->detach('/error_404') if !$c->stash->{object};
  die "Book $id not found!" if !$c->stash->{object};

  # Print a message to the debug log
  $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

=head2 url_create

Create a book with the supplied title, rating, and author

=cut

sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
  # Catalyst automatically puts extra information
  # after the "/<controller_name>/<action_name/" into @_
  my ($self, $c, $title, $rating, $author_id) = @_;

  my $time = localtime(time);
  print("___________ $time __________url_create \n");

  if ($c->check_user_roles('admin')) {
    my $book = $c->model('DB::Book')->create({
      title   => $title,
      rating  => $rating
    });

    $book->add_to_book_authors({author_id => $author_id});
    # Note: Above is a shortcut for this:
    # $book->create_related('book_authors', {author_id => $author_id});

    # Assign the Book object to the stash and set template
    $c->stash(book     => $book,
      template => 'books/create_done.tt2');

    # $c->response->header('Cache-Control' => 'no-cache');

  } else {
    $c->response->body('Unauthorized!');
  }
}

=head2 form_create

Display form to collect information for book to create

=cut

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("___________ $time __________form_create \n");

  # Set the TT template to use
  $c->stash(template => 'books/form_create.tt2');
}

=head2 form_create_do

Take information from form and add to database

=cut

sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("___________ $time __________form_create_do \n");

  # Retrieve the values from the form
  my $title     = $c->request->params->{title}     || 'N/A';
  my $rating    = $c->request->params->{rating}    || 'N/A';
  my $author_id = $c->request->params->{author_id} || '1';

  # Create the book
  my $book = $c->model('DB::Book')->create({
    title   => $title,
    rating  => $rating,
  });
  # Handle relationship with author
  $book->add_to_book_authors({author_id => $author_id});
  # Note: Above is a shortcut for this:
  # $book->create_related('book_authors', {author_id => $author_id});

  # Store new model object in stash and set template
  $c->stash(book     => $book,
    template => 'books/create_done.tt2');
}

=head2 delete

Delete a book

=cut

sub delete :Chained('object') :PathPart('delete') :Args(0) {
  my ($self, $c) = @_;

  my $time = localtime(time);
  print("___________ $time __________delete \n");


  # Check permissions
  $c->detach('/error_noperms')
    unless $c->stash->{object}->delete_allowed_by($c->user->get_object);

  # Saved the PK id for status_msg below
  my $id = $c->stash->{object}->id;

  # Use the book object saved by 'object' and delete it along
  # with related 'book_authors' entries
  $c->stash->{object}->delete;

  $c->response->redirect($c->uri_for($self->action_for('books_list'),
    {mid => $c->set_status_msg("Deleted book $id")}));
}

=head2 list_recent

List recently created books

=cut

sub list_recent :Chained('base') :PathPart('list_recent') :Args(1) {
    my ($self, $c, $mins) = @_;

    # Retrieve all of the book records as book model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve books created within the last $min number of minutes
    $c->stash(books => [$c->model('DB::Book')
                            ->created_after(DateTime->now->subtract(minutes => $mins))]);

    $c->stash(template => 'books/list.tt2');
}

=head2 list_recent_tcp

List recently created books

=cut

sub list_recent_tcp :Chained('base') :PathPart('list_recent_tcp') :Args(1) {
    my ($self, $c, $mins) = @_;

    # Retrieve all of the book records as book model objects and store in the
    # stash where they can be accessed by the TT template, but only
    # retrieve books created within the last $min number of minutes
    # AND that have 'TCP' in the title
    $c->stash(books => [
            $c->model('DB::Book')
                ->created_after(DateTime->now->subtract(minutes => $mins))
                #->search({title => {'like', '%TCP%'}})done on resultset now
                ->title_like('TCP')
        ]);

    $c->stash(template => 'books/list.tt2');
}

=encoding utf8

=head1 AUTHOR

fab,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify

=cut

__PACKAGE__->meta->make_immutable;

1;

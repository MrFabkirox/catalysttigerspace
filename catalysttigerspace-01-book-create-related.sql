--
-- Create a simple db to hold book and author info
--
PRAGMA foreign_keys = ON;
CREATE TABLE book (
  id          INTEGER PRIMARY KEY,
  title       TEXT ,
  rating      INTEGER,
  created     TIMESTAMP,
  updated     TIMESTAMP
);
CREATE TABLE author (
  id          INTEGER PRIMARY KEY,
  first_name  TEXT,
  last_name   TEXT
);
-- 'book_author' is a many-to-many join table between books & authors
CREATE TABLE book_author (
  book_id     INTEGER REFERENCES book(id) ON DELETE CASCADE ON UPDATE CASCADE,
  author_id   INTEGER REFERENCES author(id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (book_id, author_id)
);

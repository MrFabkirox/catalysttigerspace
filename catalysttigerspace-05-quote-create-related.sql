--
-- Create a very simple database to hold quotes info 
--
PRAGMA foreign_keys = ON;
CREATE TABLE quote (
  id       INTEGER PRIMARY KEY,
  quote    TEXT
);
CREATE TABLE quote_from (
  id       INTEGER PRIMARY KEY,
  name     TEXT
);
CREATE TABLE quote_by (
  id       INTEGER PRIMARY KEY,
  name     TEXT
);
-- 'quote_quote_from_quote_by' is a many-to-many join table between quote, quote_from and quote_by
CREATE TABLE quote_saying_from_by (
  quote_id INTEGER REFERENCES quote(id) ON DELETE CASCADE ON UPDATE CASCADE,
  from_id  INTEGER REFERENCES quote_from(id) ON DELETE CASCADE ON UPDATE CASCADE,
  by_id    INTEGER REFERENCES quote_by(id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (quote_id, from_id, by_id)
);

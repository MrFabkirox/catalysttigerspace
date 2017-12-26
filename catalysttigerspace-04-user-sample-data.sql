--
-- Load up some initial test data
--
INSERT INTO users VALUES (1, '1test', 'tester', 't01@na.com', 'Joe',  'Blow', 1);
INSERT INTO users VALUES (2, '2test', 'tester', 't02@na.com', 'Jane', 'Doe',  1);
INSERT INTO users VALUES (3, '3test', 'tester', 't03@na.com', 'No',   'Go',   0);
INSERT INTO role VALUES (1, 'user');
INSERT INTO role VALUES (2, 'admin');
INSERT INTO user_role VALUES (1, 1);
INSERT INTO user_role VALUES (1, 2);
INSERT INTO user_role VALUES (2, 1);
INSERT INTO user_role VALUES (3, 1);

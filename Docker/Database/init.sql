-- Create the 'servers' table
CREATE TABLE servers (
  id serial PRIMARY KEY,
  name VARCHAR(255),
  ip_address VARCHAR(15),
  ssh_username VARCHAR(255),
  ssh_password VARCHAR(255)
);


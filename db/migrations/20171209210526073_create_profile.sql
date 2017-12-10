-- +micrate Up
CREATE TABLE profiles (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS profiles;


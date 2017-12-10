-- +micrate Up
CREATE TABLE boards (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(255),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- +micrate Down
DROP TABLE IF EXISTS boards;


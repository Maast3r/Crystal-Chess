-- +micrate Up
CREATE TABLE pieces (
  id BIGSERIAL PRIMARY KEY,
  color BOOLEAN,
  name VARCHAR(255),
  x INT,
  y INT,
  board_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX 'board_id_idx' ON TABLE pieces (board_id)

-- +micrate Down
DROP TABLE IF EXISTS pieces;


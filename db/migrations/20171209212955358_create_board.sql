-- +micrate Up
CREATE TABLE boards (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(255),
  game_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX 'game_id_idx' ON TABLE boards (game_id)

-- +micrate Down
DROP TABLE IF EXISTS boards;


-- +micrate Up
CREATE TABLE games (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255),
  profile_id BIGINT,
  profile2_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX 'profile_id_idx' ON TABLE games (profile_id)
CREATE INDEX 'profile2_id_idx' ON TABLE games (profile2_id)

-- +micrate Down
DROP TABLE IF EXISTS games;


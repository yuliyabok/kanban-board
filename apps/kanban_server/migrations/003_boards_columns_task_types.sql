CREATE TABLE IF NOT EXISTS boards (
  id uuid PRIMARY KEY,
  owner_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  workspace_id uuid NULL REFERENCES workspaces(id) ON DELETE SET NULL,
  title text NOT NULL,
  description text NULL,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL,
  deleted_at timestamptz NULL
);

CREATE TABLE IF NOT EXISTS board_members (
  id text PRIMARY KEY,
  board_id uuid NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role text NOT NULL,
  joined_at timestamptz NOT NULL,
  UNIQUE (board_id, user_id)
);

CREATE TABLE IF NOT EXISTS board_columns (
  id uuid PRIMARY KEY,
  board_id uuid NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  title text NOT NULL,
  position integer NOT NULL,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL,
  deleted_at timestamptz NULL
);

CREATE TABLE IF NOT EXISTS task_types (
  id uuid PRIMARY KEY,
  board_id uuid NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  name text NOT NULL,
  color text NOT NULL,
  icon text NOT NULL,
  description text NULL,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL,
  deleted_at timestamptz NULL
);

CREATE INDEX IF NOT EXISTS boards_owner_id_idx
  ON boards(owner_id);

CREATE INDEX IF NOT EXISTS boards_workspace_id_idx
  ON boards(workspace_id);

CREATE INDEX IF NOT EXISTS board_members_user_id_idx
  ON board_members(user_id);

CREATE INDEX IF NOT EXISTS board_columns_board_id_idx
  ON board_columns(board_id);

CREATE INDEX IF NOT EXISTS task_types_board_id_idx
  ON task_types(board_id);

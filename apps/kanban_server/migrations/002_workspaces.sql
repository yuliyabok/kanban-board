CREATE TABLE IF NOT EXISTS workspaces (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  owner_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL
);

CREATE TABLE IF NOT EXISTS workspace_members (
  id text PRIMARY KEY,
  workspace_id uuid NOT NULL REFERENCES workspaces(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role text NOT NULL,
  joined_at timestamptz NOT NULL,
  UNIQUE (workspace_id, user_id)
);

CREATE INDEX IF NOT EXISTS workspaces_owner_id_idx
  ON workspaces(owner_id);

CREATE INDEX IF NOT EXISTS workspace_members_user_id_idx
  ON workspace_members(user_id);

CREATE INDEX IF NOT EXISTS workspace_members_workspace_id_idx
  ON workspace_members(workspace_id);

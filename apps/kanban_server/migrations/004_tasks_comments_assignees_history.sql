CREATE TABLE IF NOT EXISTS tasks (
  id uuid PRIMARY KEY,
  board_id uuid NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  column_id uuid NULL REFERENCES board_columns(id) ON DELETE SET NULL,
  parent_task_id uuid NULL REFERENCES tasks(id) ON DELETE SET NULL,
  task_type_id uuid NULL REFERENCES task_types(id) ON DELETE SET NULL,
  title text NOT NULL,
  description text NULL,
  card_background_color text NULL,
  card_text_color text NULL,
  position integer NOT NULL,
  depth integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'todo',
  priority text NOT NULL DEFAULT 'medium',
  assignee_name text NULL,
  labels_json text NOT NULL DEFAULT '[]',
  start_date timestamptz NULL,
  due_date timestamptz NULL,
  completed_at timestamptz NULL,
  estimated_duration_minutes integer NULL,
  actual_duration_minutes integer NULL,
  period_type text NOT NULL DEFAULT 'custom',
  is_completed boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL,
  deleted_at timestamptz NULL
);

CREATE TABLE IF NOT EXISTS task_comments (
  id uuid PRIMARY KEY,
  task_id uuid NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  author_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  content text NOT NULL,
  created_at timestamptz NOT NULL,
  updated_at timestamptz NOT NULL,
  deleted_at timestamptz NULL
);

CREATE TABLE IF NOT EXISTS task_assignees (
  id uuid PRIMARY KEY,
  task_id uuid NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  assigned_by uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  assigned_at timestamptz NOT NULL,
  UNIQUE (task_id, user_id)
);

CREATE TABLE IF NOT EXISTS task_history (
  id uuid PRIMARY KEY,
  task_id uuid NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  board_id uuid NOT NULL REFERENCES boards(id) ON DELETE CASCADE,
  action text NOT NULL,
  summary text NOT NULL,
  details_json text NULL,
  actor_user_id uuid NULL REFERENCES users(id) ON DELETE SET NULL,
  changed_at timestamptz NOT NULL
);

CREATE INDEX IF NOT EXISTS tasks_board_id_idx ON tasks(board_id);
CREATE INDEX IF NOT EXISTS tasks_column_id_idx ON tasks(column_id);
CREATE INDEX IF NOT EXISTS task_comments_task_id_idx ON task_comments(task_id);
CREATE INDEX IF NOT EXISTS task_assignees_task_id_idx ON task_assignees(task_id);
CREATE INDEX IF NOT EXISTS task_history_task_id_idx ON task_history(task_id);
CREATE INDEX IF NOT EXISTS task_history_changed_at_idx ON task_history(changed_at);

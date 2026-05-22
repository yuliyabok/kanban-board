# Kanban Board Premium UI/UX System

Product direction: calm, fast, desktop-first productivity SaaS with the clarity of Linear, the density of Notion, and the native polish of modern macOS apps. The interface should feel expensive because it is restrained, consistent, responsive, and operationally efficient.

## 1. Design Principles

- Clarity before decoration: every surface exists to help users scan, decide, and act.
- Desktop-first, mobile-adaptive: the board is an operational workspace on web/desktop and a focused task triage flow on mobile.
- Calm premium aesthetic: neutral surfaces, crisp borders, subtle shadows, controlled accent color, no oversized gradients.
- Motion as feedback: animations confirm state changes, drag intent, save status, and navigation continuity.
- Scale by default: board columns and cards must support virtualization, lazy data loading, keyboard navigation, and offline sync.
- Accessibility is part of polish: visible focus, minimum 44 px touch targets, contrast-safe tokens, semantic labels, reduced motion support.

## 2. Color System

Primary palette:

- `primary`: `#4F7DFF` light, `#8DA8FF` dark. Used for primary actions, focus rings, selected navigation, active filters.
- `surface`: `#F7F8FB` light, `#0E1117` dark. App background.
- `surfaceContainerLowest`: `#FFFFFF` light, `#12161F` dark. Cards, sidebars, popovers.
- `outlineVariant`: `#E8EBF1` light, `#2A303D` dark. Hairline borders.
- `onSurface`: `#12151C` light, `#E7EAF0` dark. Main text.
- `onSurfaceVariant`: `#667085` light, `#A5ADBC` dark. Secondary text.

Semantic palette:

- Success: `#22A06B` for synced, completed, healthy automation.
- Warning: `#B7791F` for delayed sync, due soon, review required.
- Danger: `#E5484D` for destructive actions, failed sync, blocked tasks.
- Info: primary blue with low-alpha containers.

Usage rules:

- Use accent color sparingly. The board itself should be mostly neutral.
- Status colors appear as dots, chips, thin bars, or icons, not large blocks.
- Glassmorphism is allowed only for command palette, global top bar, and transient overlays: max 70-85% opacity plus blur, always with a border.

## 3. Typography System

Recommended pairing:

- Primary: Inter or SF Pro Text for app UI.
- Optional mono: JetBrains Mono for task IDs, keyboard shortcuts, automation logs.

Flutter implementation:

- `display*`: marketing or rare empty states only.
- `headlineMedium`: page titles, workspace names.
- `headlineSmall`: board titles, settings sections.
- `titleMedium`: cards, modal section titles, column headers.
- `bodyMedium`: default readable UI copy.
- `bodySmall`: metadata, timestamps, sync state.
- `labelLarge/Medium`: buttons, tabs, chips, command rows.

Rules:

- Letter spacing stays `0`.
- Avoid viewport-based font scaling.
- Dense work surfaces use smaller headings than landing pages.
- Long task titles clamp to 2-3 lines on cards and open full text in detail panel.

## 4. Spacing System

Base tokens in Flutter:

- `xs: 4`
- `sm: 8`
- `md: 12`
- `lg: 16`
- `xl: 24`
- `xxl: 32`
- `xxxl: 48`

Layout rules:

- App chrome: 24-40 px page padding by breakpoint.
- Column gap: 12-16 px.
- Card inner padding: 12-16 px.
- Modal padding: 24 px desktop, 16 px mobile.
- Dense lists may use 8-12 px row rhythm, never cramped below touch/accessibility limits.

## 5. Radius System

- `xs: 6`: checkboxes, status pills.
- `sm: 8`: compact controls, chips.
- `md: 10`: inputs, buttons.
- `lg: 12`: task cards, board cards.
- `xl: 16`: prominent cards, FAB.
- `modal: 20`: dialogs and sheets.

Avoid excessive pill shapes except search fields, filter chips, avatars, and command shortcuts.

## 6. Elevation And Shadows

Premium SaaS elevation is mostly border-led:

- Level 0: page background, no shadow.
- Level 1: cards with `outlineVariant` border, shadow only on hover.
- Level 2: popovers/context menus with soft 18-30 px shadow.
- Level 3: dragged cards with stronger 20-36 px shadow and 1-2 px lift.
- Level 4: modal scrim plus focused dialog, no heavy material elevation.

Use shadows as interaction feedback, not static decoration.

## 7. Motion System

Durations:

- Fast: 120 ms for hover, icon state, small fades.
- Base: 180 ms for card lift, button feedback, chips.
- Slow: 260 ms for panels, dialogs, command palette, route transitions.

Curves:

- Standard: `easeInOutCubic`
- Emphasized: `easeOutCubic`

Interactions:

- Hover: border darkens, card lifts -1 px, shadow appears.
- Press: scale to 0.99 for large interactive cards, opacity/ink for compact controls.
- Drag start: card lifts, rotates at most 0.3 deg, shadow increases, placeholder keeps size.
- Drop: spring-like settle under 260 ms.
- Respect reduced motion by disabling large translations and using fades.

## 8. Component Library

Foundation widgets:

- `PremiumCard`: bordered, hover-aware, reusable for boards/tasks/settings blocks.
- `AppEmptyState`: icon container, title, message, optional action.
- `LoadingSkeleton` + `SkeletonBlock`: shimmer without layout shift.
- `AppAdaptive`: breakpoint and layout helper.

Next production widgets:

- `AppShell`: sidebar + top bar + content slot.
- `WorkspaceSwitcher`: avatar tile, workspace name, plan/status, menu.
- `SidebarItem`: icon, label, badge, selected/hover/focus variants.
- `BoardColumn`: virtualized task list with sticky header and add button.
- `TaskCard`: compact/default/detailed variants.
- `TaskDetailPanel`: right-side inspector on desktop, bottom sheet on mobile.
- `CommandPalette`: fuzzy search, grouped actions, keyboard shortcuts.
- `ContextMenu`: action groups, danger section, shortcuts.
- `SearchField`: global search with filters and recent items.
- `ActivityItem`: actor, verb, target, timestamp, compact diff.
- `CommentComposer`: markdown-lite field, mentions, attachments placeholder.
- `NotificationToast`: success/error/sync variants with action.

## 9. Responsive Breakpoints

Implemented:

- Compact: `<720`
- Medium: `720-1079`
- Expanded: `1080-1439`
- Wide: `>=1440`

Behavior:

- Compact: bottom navigation or collapsed top tabs, single-column task flow, board columns as horizontally swipable lanes or status filter.
- Medium: collapsible sidebar, 2-column board gallery, board retains horizontal scroll.
- Expanded: persistent sidebar, command/search top bar, board columns visible with horizontal virtualization.
- Wide: persistent sidebar plus optional right inspector/activity panel.

## 10. Navigation UX

Desktop:

- Left sidebar: workspace switcher, main nav, board list, favorites, settings at bottom.
- Top bar: breadcrumb, global search, command palette trigger, notifications, profile.
- Board tabs: Board, List, Calendar, Activity, Settings.

Mobile:

- Top app bar with workspace/menu.
- Bottom navigation for Boards, Search, Activity, Settings.
- Board detail uses route-level transitions and bottom sheets for create/edit.

Why: desktop users need persistent context and fast switching; mobile users need focused flows and less chrome.

## 11. Sidebar Design

Layout:

- Width 264 px expanded, 72 px collapsed.
- Surface: `surfaceContainerLowest`, right border `outlineVariant`.
- Workspace switcher at top with subtle hover.
- Nav items 40 px height, 10 px radius.
- Selected state: low-alpha primary background, primary icon/text, left 2 px accent bar optional.

Interactions:

- Collapse/expand with 180 ms width animation.
- Hover reveals quick actions for board rows.
- Keyboard focus ring visible around full row.

## 12. Board Layout

Desktop board:

- Header: board title, view tabs, filters, members, share/create buttons.
- Content: horizontally scrollable columns with fixed width 304-340 px.
- Column lists use `SliverList`/virtualization or package-backed virtual lists for large datasets.
- Right inspector can open without route change on wide screens.

Performance:

- Keep each column independently scrollable for very large boards.
- Use stable card heights where possible, cache extents, keyed cards, and debounced persistence.
- Drag payload should mutate optimistic local order first, then sync.

## 13. Task Card Design

Default card:

- 12 px radius, 1 px border, neutral surface.
- Title 2 lines max.
- Metadata row: priority dot, labels, assignee avatars, comments count, due date.
- Optional left status stripe for priority/blocker.

Variants:

- Compact: title + assignee + due/status.
- Default: title + labels + metadata.
- Detailed: includes description preview/checklist progress.
- Drag preview: elevated shadow, slight scale, no layout resizing.

Why: cards remain scannable while leaving room for richer task metadata as the product grows.

## 14. Column Design

Header:

- Column title, count badge, WIP limit, `+` and menu buttons.
- Sticky inside column.
- Column background slightly darker/lighter than page, not a heavy card.

States:

- Empty: dashed drop zone with one-line prompt and add action.
- Drag over: primary outline and low-alpha fill.
- Loading: header visible, skeleton cards below.

## 15. Modal/Dialog Design

Desktop:

- Center dialog max width 560-720 px for forms.
- Task detail can be side sheet 520-640 px from right.
- Header has title, metadata, close button. Footer sticky for primary actions.

Mobile:

- Bottom sheet or full-screen dialog depending complexity.
- Create task: bottom sheet.
- Task detail/settings: full-screen with save state in app bar.

Animation: fade + 12 px scale/translate, 220-260 ms.

## 16. Context Menu Design

- 220-280 px width.
- Grouped actions with icons and shortcuts.
- Destructive actions separated by divider and danger color only on icon/text.
- Hover row background `surfaceContainer`.
- Opens near pointer on desktop, bottom action sheet on mobile.

## 17. Command Palette UX

Trigger:

- `Cmd/Ctrl + K`, search field click, sidebar button.

Layout:

- Centered overlay 640 px wide, blurred/glass surface, dim scrim.
- Input top, grouped results below: Navigate, Create, Filters, Recent, Workspace.
- Right side shows shortcuts or secondary metadata.

Interactions:

- Arrow navigation, Enter execute, Esc close.
- Fuzzy search and recent actions.
- Empty state offers "Create task named ...".

## 18. Search UX

Global search:

- Searches tasks, boards, comments, people.
- Filter chips: Assignee, Status, Label, Due, Updated.
- Results grouped by entity and show matched snippet.

Board search:

- Filters current board without route change.
- Highlight matching task cards.
- Clear filter keyboard shortcut.

## 19. Settings Page

Structure:

- Sidebar or segmented list: Profile, Workspace, Members, Notifications, Integrations, Billing, Advanced.
- Main panel max width 860 px.
- Sections are full-width blocks, not nested cards.
- Dangerous settings isolated at bottom with confirmation dialogs.

Visual hierarchy:

- Page title, section headings, short descriptions, controls aligned in rows.
- Save status shown inline: Saved, Saving, Failed.

## 20. Profile And Workspace UI

Profile:

- Avatar, name, email, role, timezone, keyboard preferences.
- Activity presence and device sessions.

Workspace:

- Workspace avatar/logo, name, URL slug, members, default board settings.
- Member rows show avatar, name, role, last active, invite status.

## 21. Notification System

In-app:

- Toasts for immediate feedback: created, moved, deleted, sync failed.
- Notification center dropdown with unread groups.
- Badges use small count pills, not bright large blocks.

Rules:

- Success toasts auto-dismiss.
- Errors persist until dismissed or action taken.
- Offline state should live in top bar and card metadata.

## 22. Activity Log UI

Layout:

- Timeline list with actor avatar, action verb, target, diff preview, timestamp.
- Group by day.
- Compact in right inspector, expanded in Activity page.

Performance:

- Paginated list with cursor loading.
- Skeleton rows preserve avatar/text layout.

## 23. Collaboration Indicators

- Avatars: 24-32 px, stacked with +N overflow.
- Presence: small green dot, tooltip with current section.
- Live editing: field-level avatar chip near focused field.
- Board viewers: top-right avatar group with popover.

## 24. Comments UI

Task detail comments:

- Thread list below description/checklist.
- Composer sticky at bottom of detail panel.
- Mentions, lightweight markdown, attachment row.
- Resolve/reopen for comment threads when attached to checklist or field.

Visual:

- Avatar, name, timestamp, body, actions on hover.
- Edited state subtle, not noisy.

## 25. Empty States

Principles:

- Explain the next useful action, not the whole product.
- Use calm icon tile, title, one sentence, one primary action.
- For columns, empty state should double as drop target.

Examples:

- No boards: create first board.
- Empty backlog: add task.
- No search results: create task from query or clear filters.
- Empty activity: show "Activity will appear as your team works."

## 26. Error States

- Inline errors for form fields.
- Toast/banner for sync and network failures.
- Full-page error only for unrecoverable page load.
- Include retry action and technical detail disclosure for debugging.
- Offline mode is a neutral state, not an error, unless sync conflicts occur.

## 27. Loading States

- Skeletons over spinners for content regions.
- Small spinner only for command buttons or top-bar sync.
- Preserve layout dimensions to avoid jump.
- Board columns can load independently.

## 28. Drag And Drop Interactions

Desktop:

- Drag handle appears on hover.
- Card lifts and follows pointer.
- Placeholder keeps exact card size.
- Valid columns highlight; invalid columns show subtle blocked cursor/message.
- Auto-scroll near board edges and column edges.

Mobile:

- Long press starts drag.
- Haptic feedback where available.
- Drop zones become larger.
- Detail actions available through bottom sheet.

Implementation:

- Use Flutter `Draggable`/`DragTarget` for custom board interactions or a proven reorder/kanban package if it supports virtualization.
- Keep reorder optimistic locally, persist with debounced command, rollback on failed sync with toast.

## 29. Mobile Adaptation

- Board gallery becomes one-column.
- Board screen shows status tabs/chips at top and a vertical task list by selected status, with optional horizontal lane swipe.
- Create/edit forms are bottom sheets.
- Sidebar becomes drawer or bottom navigation.
- Command palette becomes full-screen search.

## 30. Desktop Interactions

- Keyboard shortcuts: `Cmd/Ctrl+K`, `N` new task, `/` search, `Esc` close panel, arrows navigate cards, `E` edit, `Delete` archive.
- Hover controls reveal secondary actions.
- Right-click opens context menu.
- Multi-select with Shift/Cmd.
- Resize sidebar and optional detail panel.

## Flutter UI Architecture

Current implemented structure:

```text
lib/src/app/theme/
  app_theme.dart
  app_design_tokens.dart

lib/src/shared/ui/
  app_adaptive.dart
  app_empty_state.dart
  loading_skeleton.dart
  premium_card.dart
```

Recommended next structure:

```text
lib/src/shared/ui/
  shell/app_shell.dart
  shell/app_sidebar.dart
  shell/app_top_bar.dart
  commands/command_palette.dart
  menus/app_context_menu.dart
  board/board_column.dart
  board/task_card.dart
  board/task_detail_panel.dart
  feedback/app_banner.dart
  feedback/notification_toast.dart
  forms/app_text_field.dart
```

Theme strategy:

- `AppTheme.light()` and `AppTheme.dark()` own `ThemeData`.
- `AppSpacing`, `AppRadii`, `AppMotion`, `AppShadows` are `ThemeExtension`s.
- Feature widgets read tokens via `context.spacing`, `context.radii`, `context.motion`, `context.shadows`.
- Keep business state in Riverpod controllers; keep visual state local unless it affects persistence.

Adaptive layout strategy:

- Use `AppAdaptive.of(context)` for major layout changes.
- Prefer route/content adaptation over duplicate screens.
- Board gallery uses responsive grid.
- Board workspace uses persistent sidebar only on expanded/wide breakpoints.
- Task detail is right panel on desktop, modal/full-screen on compact.

Scalability strategy:

- Board columns should be keyed by status/id.
- Task cards should be small stateless widgets where possible.
- Use selectors/providers per column to avoid rebuilding the whole board.
- Virtualize long columns and activity feeds.
- Avoid intrinsic measurement inside scrollable board lanes.
- Use optimistic UI for drag/reorder and offline-first writes.

Icon style:

- Use rounded, 1.75-2 px stroke icons.
- Material Symbols Rounded are acceptable with current dependencies.
- Lucide/Phosphor are good future additions if the app adds an icon package.

Motion principles:

- Navigation: fade + small slide, 180-260 ms.
- Panels: translate from edge, 220-260 ms.
- Hover: 120-180 ms.
- Drag: immediate lift, smooth auto-scroll, quick settle.
- Always support reduced motion.

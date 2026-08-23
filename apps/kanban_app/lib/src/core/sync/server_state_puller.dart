// Входящая синхронизация server-mode: читает готовые HTTP endpoints backend и
// применяет снимок данных в локальный Drift-кеш приложения.
import 'dart:convert';

import 'package:kanban_contracts/kanban_contracts.dart';

import '../../features/board_members/data/dto/board_member_dto.dart'
    as board_member_dto;
import '../../features/board_members/data/mappers/board_member_mapper.dart';
import '../../features/boards/data/mappers/board_mapper.dart';
import '../../features/comments/data/dto/task_comment_dto.dart' as comment_dto;
import '../../features/comments/data/mappers/task_comment_mapper.dart';
import '../../features/task_assignees/data/dto/task_assignee_dto.dart'
    as assignee_dto;
import '../../features/task_assignees/data/mappers/task_assignee_mapper.dart';
import '../../features/task_types/data/dto/task_type_dto.dart' as task_type_dto;
import '../../features/task_types/data/mappers/task_type_mapper.dart';
import '../../features/tasks/data/dto/task_dto.dart' as task_dto;
import '../../features/tasks/data/mappers/task_history_mapper.dart';
import '../../features/tasks/data/mappers/task_mapper.dart';
import '../../features/tasks/domain/entities/task_history_entry.dart';
import '../../features/users/data/dto/user_dto.dart' as user_dto;
import '../../features/users/data/mappers/user_mapper.dart';
import '../../features/workspaces/data/dto/workspace_dto.dart' as workspace_dto;
import '../../features/workspaces/data/mappers/workspace_mapper.dart';
import '../database/app_database.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';

final class ServerStatePuller {
  const ServerStatePuller({
    required AppDatabase database,
    required ApiClient apiClient,
  }) : _database = database,
       _apiClient = apiClient;

  final AppDatabase _database;
  final ApiClient _apiClient;

  Future<void> pull() async {
    await _pullWorkspaces();
    final boardIds = await _pullBoards();
    for (final boardId in boardIds) {
      await _pullBoardMembers(boardId);
      await _pullTaskTypes(boardId);
      final tasks = await _pullTasks(boardId);
      for (final task in tasks) {
        await _pullComments(task.id);
        await _pullAssignees(task.id);
        await _pullHistory(task.id);
      }
    }
  }

  Future<List<String>> _pullBoards() async {
    final response = await _apiClient.getJson(ApiEndpoints.boards);
    final boards = _list(
      response,
      'boards',
    ).map(boardFromApiJson).toList(growable: false);

    for (final board in boards) {
      await _database
          .into(_database.boardsTable)
          .insertOnConflictUpdate(board.toCompanion(syncAction: null));
    }

    return boards.map((board) => board.id).toList(growable: false);
  }

  Future<void> _pullWorkspaces() async {
    final response = await _apiClient.getJson(ApiEndpoints.workspaces);
    final workspaces = _list(
      response,
      'workspaces',
    ).map(workspace_dto.WorkspaceDto.fromJson).toList(growable: false);

    for (final workspace in workspaces) {
      await _database
          .into(_database.workspacesTable)
          .insertOnConflictUpdate(
            workspace.toEntity().toCompanion(syncAction: null),
          );
      await _pullWorkspaceMembers(workspace.id);
    }
  }

  Future<void> _pullWorkspaceMembers(String workspaceId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.workspaceMembers(workspaceId),
    );
    final members = _list(
      response,
      'members',
    ).map(workspace_dto.WorkspaceMemberDto.fromJson).toList(growable: false);

    for (final member in members) {
      await _database
          .into(_database.workspaceMembersTable)
          .insertOnConflictUpdate(
            member.toEntity().toCompanion(syncAction: null),
          );
      await _pullUserBySearch(member.userId);
    }
  }

  Future<void> _pullBoardMembers(String boardId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.boardMembers(boardId),
    );
    final members = _list(
      response,
      'members',
    ).map(board_member_dto.BoardMemberDto.fromJson).toList(growable: false);

    for (final member in members) {
      await _database
          .into(_database.boardMembersTable)
          .insertOnConflictUpdate(
            member.toEntity().toCompanion(syncAction: null),
          );
      await _pullUserBySearch(member.userId);
    }
  }

  Future<void> _pullTaskTypes(String boardId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.taskTypes,
      queryParameters: {'boardId': boardId},
    );
    final taskTypes = _list(
      response,
      'taskTypes',
    ).map(task_type_dto.TaskTypeDto.fromJson).toList(growable: false);

    for (final taskType in taskTypes) {
      await _database
          .into(_database.taskTypesTable)
          .insertOnConflictUpdate(
            taskType.toEntity().toCompanion(syncAction: null),
          );
    }
  }

  Future<void> _pullUserBySearch(String userId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.usersSearch,
      queryParameters: {'query': userId},
    );
    final users = _list(
      response,
      'users',
    ).map(user_dto.UserDto.fromJson).toList(growable: false);

    for (final user in users.where((user) => user.id == userId)) {
      await _database
          .into(_database.usersTable)
          .insertOnConflictUpdate(
            user.toEntity().toCompanion(),
          );
    }
  }

  Future<List<task_dto.TaskDto>> _pullTasks(String boardId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.tasks,
      queryParameters: {'boardId': boardId},
    );
    final tasks = _list(
      response,
      'tasks',
    ).map(task_dto.TaskDto.fromJson).toList(growable: false);

    for (final task in tasks) {
      await _database
          .into(_database.tasksTable)
          .insertOnConflictUpdate(
            task.toEntity().toCompanion(syncAction: null),
          );
    }

    return tasks;
  }

  Future<void> _pullComments(String taskId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.taskComments(taskId),
    );
    final comments = _list(
      response,
      'comments',
    ).map(comment_dto.TaskCommentDto.fromJson).toList(growable: false);

    for (final comment in comments) {
      await _database
          .into(_database.taskCommentsTable)
          .insertOnConflictUpdate(
            comment.toEntity().toCompanion(syncAction: null),
          );
    }
  }

  Future<void> _pullAssignees(String taskId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.taskAssignees(taskId),
    );
    final assignees = _list(
      response,
      'assignees',
    ).map(assignee_dto.TaskAssigneeDto.fromJson).toList(growable: false);

    for (final assignee in assignees) {
      await _database
          .into(_database.taskAssigneesTable)
          .insertOnConflictUpdate(
            assignee.toEntity().toCompanion(syncAction: null),
          );
    }
  }

  Future<void> _pullHistory(String taskId) async {
    final response = await _apiClient.getJson(ApiEndpoints.taskHistory(taskId));
    final entries = _list(
      response,
      'history',
    ).map(TaskHistoryEntryDto.fromJson).toList(growable: false);

    for (final entry in entries) {
      await _database
          .into(_database.taskHistoryTable)
          .insertOnConflictUpdate(
            TaskHistoryEntry(
              id: entry.id,
              taskId: entry.taskId,
              boardId: entry.boardId,
              action: entry.action,
              summary: entry.summary,
              detailsJson: entry.details == null
                  ? null
                  : jsonEncode(entry.details),
              actorUserId: entry.actorUserId,
              changedAt: entry.changedAt,
            ).toCompanion(),
          );
    }
  }

  List<Map<String, dynamic>> _list(Map<String, dynamic> response, String key) {
    final items = response[key] as List<dynamic>? ?? const [];
    return items.cast<Map<String, dynamic>>();
  }
}

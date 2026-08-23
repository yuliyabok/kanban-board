// Хранение досок, участников досок, колонок и типов задач.
import 'package:kanban_contracts/kanban_contracts.dart';

abstract interface class BoardDataRepository {
  Future<List<BoardDto>> listBoards(String userId);

  Future<BoardDto> createBoard({
    required String ownerId,
    required String title,
    String? workspaceId,
    String? description,
  });

  Future<BoardDto> updateBoard({
    required String boardId,
    required String actorUserId,
    String? title,
    String? description,
  });

  Future<void> deleteBoard({
    required String boardId,
    required String actorUserId,
  });

  Future<List<BoardMemberDto>> listBoardMembers({
    required String boardId,
    required String actorUserId,
  });

  Future<BoardColumnDto> createColumn({
    required String actorUserId,
    required String boardId,
    required String title,
    required int position,
  });

  Future<BoardColumnDto> updateColumn({
    required String actorUserId,
    required String columnId,
    String? title,
    int? position,
  });

  Future<void> deleteColumn({
    required String actorUserId,
    required String columnId,
  });

  Future<List<TaskTypeDto>> listTaskTypes({
    required String actorUserId,
    required String boardId,
  });

  Future<TaskTypeDto> createTaskType({
    required String actorUserId,
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  });

  Future<TaskTypeDto> updateTaskType({
    required String actorUserId,
    required String id,
    String? name,
    String? color,
    String? icon,
    String? description,
  });

  Future<void> deleteTaskType({
    required String actorUserId,
    required String id,
  });
}

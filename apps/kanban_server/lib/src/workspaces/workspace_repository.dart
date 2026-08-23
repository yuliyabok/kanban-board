// Хранение workspace и участников. Серверный слой возвращает shared DTO,
// которые уже понимает Flutter-клиент.
import 'package:kanban_contracts/kanban_contracts.dart';

abstract interface class WorkspaceRepository {
  Future<List<WorkspaceDto>> listForUser(String userId);

  Future<WorkspaceDto> create({
    required String name,
    required String ownerId,
  });

  Future<List<WorkspaceMemberDto>> listMembers({
    required String workspaceId,
    required String actorUserId,
  });
}

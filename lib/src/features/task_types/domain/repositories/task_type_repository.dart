import '../../../../core/error/result.dart';
import '../entities/task_type_entity.dart';

abstract interface class TaskTypeRepository {
  Stream<List<TaskTypeEntity>> watchByBoard(String boardId);

  Future<List<TaskTypeEntity>> getByBoard(String boardId);

  Future<Result<TaskTypeEntity>> create({
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  });

  Future<Result<TaskTypeEntity>> update(TaskTypeEntity type);

  Future<Result<void>> delete(String id);
}

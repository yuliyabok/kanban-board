import '../../../../core/error/result.dart';
import '../entities/task_type_entity.dart';
import '../repositories/task_type_repository.dart';

final class CreateTaskTypeUseCase {
  const CreateTaskTypeUseCase(this._repository);

  final TaskTypeRepository _repository;

  Future<Result<TaskTypeEntity>> call({
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  }) {
    return _repository.create(
      boardId: boardId,
      name: name,
      color: color,
      icon: icon,
      description: description,
    );
  }
}

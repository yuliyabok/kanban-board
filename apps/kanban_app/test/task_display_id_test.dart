import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/features/tasks/presentation/widgets/task_card/task_card_models.dart';

void main() {
  test('formatTaskDisplayId uses a stable short UUID prefix', () {
    expect(
      formatTaskDisplayId('018f2f7a-5b7c-7000-8c9d-123456789abc'),
      'TSK-018F2F7A',
    );
  });

  test('formatTaskDisplayId handles short local ids', () {
    expect(formatTaskDisplayId('abc-12'), 'TSK-ABC12');
  });
}

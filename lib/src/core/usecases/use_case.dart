abstract interface class UseCase<Input, Output> {
  Future<Output> call(Input input);
}

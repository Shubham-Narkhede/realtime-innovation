part of 'CubitSqFliteDatabse.dart';

abstract class SqFliteDatabaseState extends Equatable {
  const SqFliteDatabaseState();

  @override
  List<Object> get props => [];
}

class StateInitial extends SqFliteDatabaseState {}

class StateLoading extends SqFliteDatabaseState {}

class StateSuccess extends SqFliteDatabaseState {
  StateSuccess(this.listUser);

  final List<ModelUser> listUser;

  @override
  List<Object> get props => [listUser];
}

class StateError extends SqFliteDatabaseState {
  StateError(this.error);

  final String error;

  @override
  String get getError => error;
}

class StateDeleted extends SqFliteDatabaseState {}

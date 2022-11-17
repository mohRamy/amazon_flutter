// ...و  colors و  theme و error مثل  feature فيه القصص العامة لكل ال core ال


import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
} // wrong from local database

// class WrongDataFailure extends Failure {
//   @override
//   List<Object?> get props => [];
// } // wrong from information user

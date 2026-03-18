import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends HomeEvent {}
class FilterMoviesEvent extends HomeEvent {
  final String genre;
  FilterMoviesEvent(this.genre);

  @override
  List<Object> get props => [genre];
}
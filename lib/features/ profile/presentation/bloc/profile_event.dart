import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ToggleWatchlistEvent extends ProfileEvent {
  final int movieId;
  final String title;
  final String image;
  final double rating;

  const ToggleWatchlistEvent({
    required this.movieId,
    required this.title,
    required this.image,
    required this.rating,
  });

  @override
  List<Object> get props => [movieId, title, image, rating];
}

class AddToHistoryEvent extends ProfileEvent {
  final int movieId;
  final String title;
  final String image;
  final double rating;

  const AddToHistoryEvent({
    required this.movieId,
    required this.title,
    required this.image,
    required this.rating,
  });

  @override
  List<Object> get props => [movieId, title, image, rating];
}

class CheckWatchlistEvent extends ProfileEvent {
  final int movieId;
  const CheckWatchlistEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
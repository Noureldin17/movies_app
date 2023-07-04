part of 'backdrop_image_bloc.dart';

abstract class BackdropImageEvent extends Equatable {
  const BackdropImageEvent();

  @override
  List<Object> get props => [];
}

class ChangeBackdropEvent extends BackdropImageEvent {
  final String backdropPath;

  const ChangeBackdropEvent(this.backdropPath);
}

class RestoreStateEvent extends BackdropImageEvent {}

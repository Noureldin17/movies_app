part of 'backdrop_image_bloc.dart';

abstract class BackdropImageState extends Equatable {
  const BackdropImageState();

  @override
  List<Object> get props => [];
}

class BackdropImageInitial extends BackdropImageState {}

class BackdropImageChanged extends BackdropImageState {
  final String backdropPath;

  const BackdropImageChanged(this.backdropPath);
}

class BackdropImageUnchanged extends BackdropImageState {}

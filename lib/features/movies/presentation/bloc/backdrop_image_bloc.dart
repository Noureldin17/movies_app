import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'backdrop_image_event.dart';
part 'backdrop_image_state.dart';

class BackdropImageBloc extends Bloc<BackdropImageEvent, BackdropImageState> {
  BackdropImageBloc() : super(BackdropImageInitial()) {
    on<BackdropImageEvent>((event, emit) {
      if (event is ChangeBackdropEvent) {
        emit(BackdropImageChanged(event.backdropPath));
      } else if (event is RestoreStateEvent) {
        emit(BackdropImageInitial());
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/%20profile/presentation/bloc/profile_event.dart';
import '../../domain/ repositories/profile_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/delete_account_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import 'update_profile_event.dart';
import 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ProfileRepository _repository;

  UpdateProfileBloc({
    required UpdateProfileUseCase updateProfileUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required ProfileRepository repository,
  })  : _updateProfileUseCase = updateProfileUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        _repository = repository,
        super(UpdateProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileSubmitted>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event,
      Emitter<UpdateProfileState> emit,
      ) async {
    emit(UpdateProfileLoading());
    try {
      final user = await _repository.getProfile();
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(UpdateProfileInitial());
      }
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileSubmitted event,
      Emitter<UpdateProfileState> emit,
      ) async {
    emit(UpdateProfileLoading());
    try {
      await _updateProfileUseCase(
        UserEntity(
          name: event.name,
          phone: event.phone,
          avatarIndex: event.avatarIndex,
        ),
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event,
      Emitter<UpdateProfileState> emit,
      ) async {
    emit(DeleteAccountLoading());
    try {
      await _deleteAccountUseCase();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}
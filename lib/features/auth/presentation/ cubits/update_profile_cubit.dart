import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/update_profile_repo.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo _repo;

  UpdateProfileCubit(this._repo) : super(UpdateProfileInitial());

  Future<void> loadProfile() async {
    emit(UpdateProfileLoading());
    try {
      await _repo.getProfile();
      emit(UpdateProfileInitial());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    emit(UpdateProfileLoading());
    try {
      await _repo.updateProfile(
        name: name,
        phone: phone,
        avatarIndex: avatarIndex,
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    try {
      await _repo.deleteAccount();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(UpdateProfileError(e.toString()));
    }
  }
}
import 'package:movies_app/features/auth/domian/repositories/auth_repository.dart';

import '../entities/register_request.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;


  SignUpUseCase(this._authRepository);

  Future<void> execute({required RegisterRequest request}) async{
    _authRepository.register(request: request);
  }

}
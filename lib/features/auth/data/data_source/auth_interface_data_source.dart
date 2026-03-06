import '../../domian/entities/register_request.dart';

abstract class AuthInterfaceDataSource {
  Future<void> execute({required RegisterRequest request});

}

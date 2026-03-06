import '../entities/register_request.dart';
// clean architecture: domain/data/presentation
// create the use case "entity"
// create the repository
// add the function to the repository
// create the use case class
// // the class has a reference to the repository that's sent in the class's constructor
// // excute function
abstract class AuthRepository {
  Future<void> register({ required RegisterRequest request});
}
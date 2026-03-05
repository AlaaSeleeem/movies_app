// when the model is only used in the presetation layer it's prepferred
// to do it in " entities" folder within the domain
// instead of data layer
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final int avaterId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.avaterId,
  });
}
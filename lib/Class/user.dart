import 'grupo-amigos.dart';
class User{

  late final int id;

  late String username;
  late String name;
  late String password;
  late String email;
  late String numberphone;
  late List<User> listaAmigos;
  late List<GrupoAmigos> grupoamigos;
  User(this.id, this.username,this.name, this.email , this.numberphone, this.grupoamigos);
}
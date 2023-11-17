import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite_database_example/model/note.dart'
class User{
  final int? id;
  //final String? email;
  final String username;
  final String password;
  final String contact1;
  final String? contact2;
  final String? contact3;
  final int? curruser;

  const User({this.id, required this.username, required this.password, required this.contact1,  this.contact2,  this.contact3,  this.curruser
  });

  factory User.fromJson(Map<String,dynamic> json) => User(
      id: json['id'],
      //email: json['email'],
      username: json['username'],
      password: json['password'],
      contact1: json['contact1'],
      contact2: json['contact2'],
      contact3: json['contact3'],
      curruser: json['curruser']
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    //'email':email,
    'username':username,
    'password':password,
    'contact1':contact1,
    'contact2':contact2,
    'contact3':contact3,
    'curruser':curruser
  };


}
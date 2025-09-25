
import 'package:bim/core/extensions/extension_on_privileges.dart';
import '../core/constants/enums/privileges.dart';
import 'privilege.dart';

class User {
  String? password;
  String? email;
  String? admin;
  String? firstName;
  String? lastName;
  String? id;
  String? token;
  double? total;

  List<Privilege>? privileges;



  User(
      {this.password,
        this.email,
        this.admin,
        this.firstName,
        this.lastName,
        this.id,
        this.token,
        this.total,
        this.privileges,

       });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"].toString(),
      email: json["email"]??json["username"],
      password: json["password"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      admin: json["admin"],
      token: json["token"],
      total: json["total"],
      privileges: json['privileges']!=null?(json['privileges'] as List).map((json)=>Privilege.fromJson(json)).toList():null
  );


  bool hasAccess(Privileges privilege){
    String code=privilege.code;
    if(privileges?.isNotEmpty ?? false){
      Privilege privilegeEntity=(privileges!.where((element) => element.code==code).toList()).elementAt(0);
      return (privilegeEntity.privilegeId!>1);
    }
    return false;
  }


  bool get hasAccessTeleferique{
    return (hasAccess(Privileges.TSuperettes) || hasAccess(Privileges.TGuichets));
  }

  bool get hasAccessWP{
    return (hasAccess(Privileges.WPGuichets) || hasAccess(Privileges.WPSuperettes) || hasAccess(Privileges.RMS));
  }

  bool get hasAccessAdministration{
    return (hasAccess(Privileges.Historique)  && hasAccess(Privileges.Utilisateurs));
  }

  bool get hasAnyAccess{
    return (hasAccessWP || hasAccessTeleferique || hasAccessAdministration);
  }


  String get fullName{
    return "$firstName-$lastName";
  }
  List<Privilege> get onlyAuthorisedPriv{
    List<Privilege> res=privileges?.where((element) => element.privilegeId!>1).toList()??[];
    return res;
  }

  User copyWith({String? password,
  String? email,
  String? admin,
  String? firstName,
  String? lastName,
  String? id,
  String? token,
  double? total,
  List<Privilege>? privileges}){
    return User(
      total: total ?? this.total,
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      privileges: privileges??this.privileges,
      lastName: lastName??this.lastName,
      firstName: firstName??this.firstName,
      admin: admin??this.admin,
      password: password??this.password,
    );
  }


}




class Privilege {
  int? id;
  String? parentId;
  String? title;
  String? code;
  String? privilege;
  int? privilegeId;

  Privilege(
      {this.id,
      this.parentId,
      this.title,
      this.code,
      this.privilege,
      this.privilegeId});


  factory Privilege.fromJson(Map<String,dynamic> json){
    return Privilege(
        id: json['id'],
        code: json['code'],
        title: json['title'],
        parentId: json['parent_id'],
        privilege: json['privilege'],
        privilegeId: json['privilegeId']
    );
  }
}
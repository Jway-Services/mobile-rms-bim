import '../constants/enums/privileges.dart';

extension ext_on_privi on Privileges{


  String get code {
    String code = "";
    switch (this) {
      case Privileges.WPGuichets:
        code = "wp_guichets";
        break;
      case Privileges.WPSuperettes:
        code = "wp_superettes";
        break;
      case Privileges.RMS:
        code = "wp_rms";
        break;
      case Privileges.TGuichets:
        code = "t_guichets";
        break;
      case Privileges.TSuperettes:
        code = "t_superettes";
        break;
      case Privileges.Historique:
        code = "mob_historique";
        break;
      case Privileges.Utilisateurs:
        code = "mob_utilisateur";
        break;
      case Privileges.Parking:
        code = "t_parking";
    }
    return code;
  }
}

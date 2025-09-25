part of 'historique_bloc.dart';

@immutable
abstract class HistoriqueEvent {}


class FetchHistorique extends HistoriqueEvent{}

class DeleteHistorique extends HistoriqueEvent{
  Historique historiqueEntity;

  DeleteHistorique(this.historiqueEntity);
}


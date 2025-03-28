enum Status { pending, ready, completed, eliminated }

Status getStatusFromInt(int statusInteger) {
  switch (statusInteger) {
    case 0:
      return Status.pending;
    case 1:
      return Status.ready;
    case 2:
      return Status.completed;
    case 3:
      return Status.eliminated;
    default:
      return Status.pending;
  }
}

int getIntFromStatus(Status status) {
  switch (status) {
    case Status.pending:
      return 0;
    case Status.ready:
      return 1;
    case Status.completed:
      return 2;
    case Status.eliminated:
      return 3;
  }
}

String statusToString(Status status) {
  switch (status) {
    case Status.pending:
      return "Pendiente";
    case Status.ready:
      return "Preparado";
    case Status.completed:
      return "Completado";
    case Status.eliminated:
      return "Eliminado";
  }
}

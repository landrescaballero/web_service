String minutero(int tiempo) {
  int minutos = tiempo ~/ 60;
  int segundos = tiempo % 60;
  String min = minutos.toString();
  String seg = segundos.toString();
  if (minutos < 10) {
    min = "0$minutos";
  }
  if (segundos < 10) {
    seg = "0$segundos";
  }
  return "$min:$seg";
}

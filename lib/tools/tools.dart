class Tools {
  ///Restituisce una stringa corrispondente alla stringa in input
  ///in formato dd-mm-YY, se la stringa in input non è una data valida
  ///restituisce una stringa vuota
  static convertDate(String date) {
    List<String> splitted = date.split("-");
    String formatted = "";
    if (splitted.length == 3) {
      if (splitted[0].length == 4)
        formatted = splitted[2] + "-" + splitted[1] + "-" + splitted[0];
      if (splitted[2].length == 4) formatted = date;
    }
    return formatted;
  }
}

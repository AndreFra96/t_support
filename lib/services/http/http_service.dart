import 'package:http/http.dart' as http;

class HTTPservice {
  static Future<http.Response> fetchCustomerAndLocation(String codCliente) {
    return http
        .get('https://rca-ordini.cloud/SITO/api/customer.php?id=' + codCliente);
  }

  static Future<http.Response> fetchLocation(String piva) {
    return http
        .get('https://rca-ordini.cloud/SITO/api/location.php?piva=' + piva);
  }

  static Future<http.Response> rinnoviAnnuali(
      String customer, String location) {
    return http.get(
        'https://rca-ordini.cloud/SITO/api/rinnoviAnnuali.php?customer=' +
            customer +
            '&location=' +
            location);
  }

  static Future<http.Response> rinnoviBiennali(
      String customer, String location) {
    return http.get(
        'https://rca-ordini.cloud/SITO/api/rinnoviBiennali.php?customer=' +
            customer +
            '&location=' +
            location);
  }

  static Future<http.Response> rinnoviMensili(
      String customer, String location) {
    return http.get(
        'https://rca-ordini.cloud/SITO/api/rinnoviMensili.php?customer=' +
            customer +
            '&location=' +
            location);
  }

  static Future<http.Response> rinnoviNewYear(
      String customer, String location) {
    return http.get(
        'https://rca-ordini.cloud/SITO/api/rinnoviNewYear.php?customer=' +
            customer +
            '&location=' +
            location);
  }

  static Future<http.Response> rinnoviPrestitiAnnuali(
      String customer, String location) {
    return http.get(
        'https://rca-ordini.cloud/SITO/api/rinnoviPrestitiAnnuali.php?customer=' +
            customer +
            '&location=' +
            location);
  }
}

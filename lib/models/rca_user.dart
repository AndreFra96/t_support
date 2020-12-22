import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:support/models/rca_article.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/services/firestore/firestore_service.dart';
import 'package:support/services/http/http_service.dart';

class RcaUser extends ChangeNotifier {
  final UserCredential firebaseUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userCode;
  String ragsoc;
  String piva;
  Map<String, RcaLocation> locations;
  String activeLocationID;

  RcaUser({@required this.firebaseUser});

  ///Restituisce true se RcaUser non è completo, false altrimenti
  bool isEmpty() {
    return userCode == null ||
        ragsoc == null ||
        piva == null ||
        locations == null;
  }

  Map<String, dynamic> toMap() {
    return {
      'userCode': userCode,
      'ragsoc': ragsoc,
      'piva': piva,
      'activeLocationID': activeLocationID
    };
  }

  RcaLocation activeLocation() {
    return locations == null ? null : locations[activeLocationID];
  }

  ///Richiama il metodo sessionStream sulla sessione dell'utente firebase attuale,
  ///attraverso l'attributo 'exist' di DocumentSnapsot è possibile stabilire se
  ///l'utente firebase è loggato (ovvero è presente una sessione per l'utente
  ///firebase attuale) o se non lo è, l'app deve aggiornarsi in base a questo
  ///stream
  Stream<DocumentSnapshot> loggingStatus() {
    return FirestoreService.sessionStream(firebaseUser.user.uid);
  }

  ///Chiude la sessione dell'utente attuale e invia la notifica ai listeners,
  ///questo provoca il logout dall'applicazione dato che essa è in ascolto attraverso
  ///lo stream restituito da loggingStatus
  logOut() async {
    await quitSession();
    notifyListeners();
  }

  ///Se l'utente firebase attuale ha una sessione attiva, modifica l'RcaUser
  ///attuale inserendo i dati contenuti nella sessione attiva
  Future<void> populateUserFromSession() async {
    DocumentSnapshot doc =
        await FirestoreService.sessionDocument(firebaseUser.user.uid);
    Map<String, dynamic> data = doc.data();
    this.userCode = data['customer_id'];
    this.ragsoc = data['ragsoc'];
    this.piva = data['piva'];
    this.locations =
        await FirestoreService.sessionLocations(firebaseUser.user.uid);
    this.activeLocationID = doc.data()['active_location'];
    notifyListeners();
    return;
  }

  ///Legge una stringa formattata in formato JSON contenente dei locali, per ogni
  ///locale crea un RcaLocation e la inserisce nei locali dell'RcaUser.
  ///Attraverso il parametro sostituisci è possibile aggiungere i locali letti
  ///nel file JSON e importarli senza eliminare eventuali locali già presenti
  void populateLocationFromJsonData(formattedJson, {bool sostituisci = true}) {
    if (locations == null || sostituisci)
      locations = new Map<String, RcaLocation>();
    if (formattedJson != null) {
      for (int i = 0; i < formattedJson.length; i++) {
        RcaLocation temp = new RcaLocation(
            address: formattedJson[i]['location_address'],
            locationID: formattedJson[i]['location_id'],
            name: formattedJson[i]['location_loc_desc'],
            piva: formattedJson[i]['location_piva']);
        print(temp);
        locations.putIfAbsent(temp.locationID, () => temp);
      }
    }
  }

  Future<List<RcaArticle>> rinnoviAnnuali() async {
    Response r = await HTTPservice.rinnoviAnnuali(userCode, activeLocationID);
    dynamic body = jsonDecode(r.body);
    List<RcaArticle> articles = new List<RcaArticle>();
    for (int i = 0; i < body.length; i++) {
      articles.add(RcaArticle(
          title: body[i]['article_app_title'] == null
              ? "Titolo"
              : body[i]['article_app_title'],
          articleID: body[i]['article_id_trace'] == null
              ? "Id"
              : body[i]['article_id_trace'],
          renew: body[i]['date_rinnovo'] == null
              ? "Rinnovo"
              : body[i]['date_rinnovo'],
          price: body[i]['price'] == null ? "Prezzo" : body[i]['price'],
          imgPath: body[i]['article_immagine'] == null
              ? "pathNotFound"
              : body[i]['article_immagine'].replaceAll("../", "")));
    }
    return articles;
  }

  Future<List<RcaArticle>> rinnoviMensili() async {
    Response r = await HTTPservice.rinnoviMensili(userCode, activeLocationID);
    dynamic body = jsonDecode(r.body);
    List<RcaArticle> articles = new List<RcaArticle>();
    for (int i = 0; i < body.length; i++) {
      articles.add(RcaArticle(
          title: body[i]['article_app_title'] == null
              ? "Titolo"
              : body[i]['article_app_title'],
          articleID: body[i]['article_id_trace'] == null
              ? "Id"
              : body[i]['article_id_trace'],
          renew: body[i]['date_rinnovo'] == null
              ? "Rinnovo"
              : body[i]['date_rinnovo'],
          price: body[i]['price'] == null ? "Prezzo" : body[i]['price'],
          imgPath: body[i]['article_immagine'] == null
              ? "pathNotFound"
              : body[i]['article_immagine'].replaceAll("../", "")));
    }
    return articles;
  }

  Future<List<RcaArticle>> rinnoviBiennali() async {
    Response r = await HTTPservice.rinnoviBiennali(userCode, activeLocationID);
    dynamic body = jsonDecode(r.body);
    List<RcaArticle> articles = new List<RcaArticle>();
    for (int i = 0; i < body.length; i++) {
      articles.add(RcaArticle(
          title: body[i]['article_app_title'] == null
              ? "Titolo"
              : body[i]['article_app_title'],
          articleID: body[i]['article_id_trace'] == null
              ? "Id"
              : body[i]['article_id_trace'],
          renew: body[i]['date_rinnovo'] == null
              ? "Rinnovo"
              : body[i]['date_rinnovo'],
          price: body[i]['price'] == null ? "Prezzo" : body[i]['price'],
          imgPath: body[i]['article_immagine'] == null
              ? "pathNotFound"
              : body[i]['article_immagine'].replaceAll("../", "")));
    }
    return articles;
  }

  Future<List<RcaArticle>> rinnoviNewYear() async {
    Response r = await HTTPservice.rinnoviNewYear(userCode, activeLocationID);
    dynamic body = jsonDecode(r.body);
    List<RcaArticle> articles = new List<RcaArticle>();
    for (int i = 0; i < body.length; i++) {
      articles.add(RcaArticle(
          title: body[i]['article_app_title'] == null
              ? "Titolo"
              : body[i]['article_app_title'],
          articleID: body[i]['article_id_trace'] == null
              ? "Id"
              : body[i]['article_id_trace'],
          renew: body[i]['date_rinnovo'] == null
              ? "Rinnovo"
              : body[i]['date_rinnovo'],
          price: body[i]['price'] == null ? "Prezzo" : body[i]['price'],
          imgPath: body[i]['article_immagine'] == null
              ? "pathNotFound"
              : body[i]['article_immagine'].replaceAll("../", "")));
    }
    return articles;
  }

  Future<List<RcaArticle>> rinnoviPrestitiAnnuali() async {
    Response r =
        await HTTPservice.rinnoviPrestitiAnnuali(userCode, activeLocationID);
    dynamic body = jsonDecode(r.body);
    List<RcaArticle> articles = new List<RcaArticle>();
    for (int i = 0; i < body.length; i++) {
      articles.add(RcaArticle(
          title: body[i]['article_app_title'] == null
              ? "Titolo"
              : body[i]['article_app_title'],
          articleID: body[i]['article_id_trace'] == null
              ? "Id"
              : body[i]['article_id_trace'],
          renew: body[i]['date_rinnovo'] == null
              ? "Rinnovo"
              : body[i]['date_rinnovo'],
          price: body[i]['price'] == null ? "Prezzo" : body[i]['price'],
          imgPath: body[i]['article_immagine'] == null
              ? "pathNotFound"
              : body[i]['article_immagine'].replaceAll("../", "")));
    }
    return articles;
  }

  bool changeActiveLocation(String locationID) {
    if (locationID != null && locations[locationID] != null) {
      this.activeLocationID = locationID;
      FirestoreService.updateSessionActiveLocation(
          firebaseUser.user.uid, locationID);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  ///Effettua il login nell'applicazione.
  ///effettua una richiesta alle API di t_order e richiede vengano resitituiti
  ///i dati di un cliente partendo dal codice cliente inserito in input, i dati
  ///ricevuti vengono formattati in JSON.
  ///Se la variabile JSON ottenuta è diversa da null e ha lunghezza maggiore di
  ///zero, viene controllato se la partita iva in input corrisponde con la partita
  ///iva del cliente con quel codice cliente
  ///In caso positivo viene inizializzato l'RcaUser con i dati ottenuti dall API,
  ///viene creato un documento nella collezione users corrispondente all'RcaUser
  ///attuale e viene inizializzata una sessione per l'RcaUser, questo permette
  ///di accedere.
  ///Questo metodo restituisce una stringa con informazioni sul successo o meno
  ///dell'operazione di login
  Future<String> logIn(String userCode, String inputPiva) async {
    Response r = await HTTPservice.fetchCustomerAndLocation(userCode);
    dynamic formattedJson;
    String response;
    try {
      formattedJson = jsonDecode(r.body);
      if (formattedJson != null && formattedJson.length != 0) {
        if (inputPiva == formattedJson['customer_piva']) {
          this.userCode = formattedJson['customer_id_trace'];
          this.ragsoc = formattedJson['customer_ragsoc'];
          this.piva = formattedJson['customer_piva'];
          if (formattedJson['location'] != null) {
            populateLocationFromJsonData(formattedJson['location']);
          }

          FirestoreService.createFirestoreUserFromRcaUser(this);
          initSession();
        } else {
          response = "Credenziali di accesso non valide, riprovare";
        }
      } else {
        response = "Cliente non trovato, riprovare";
      }
    } catch (FormatException) {
      print(FormatException);
      print("Invalid JSON data from server API");
      response = "Cliente non trovato, riprovare";
    }
    notifyListeners();
    return response;
  }

  ///Se è stato effettuato il login, quindi l'RcaUser attuale ha un userCode
  ///valido (corrispondente all'id cliente di un cliente rca) diverso da null
  ///viene richiamato il metodo initSession di FirestoreService per inizializzare
  ///una sessione con i dati dell'utente attuale
  initSession() async {
    if (userCode != null) {
      await FirestoreService.initSession(
          firebaseUser.user.uid, userCode, piva, ragsoc, locations);
    }
    notifyListeners();
  }

  ///Se è presente una sessione per l'utente firebase attuale viene richiamato
  ///il metodo deleteSession di FirestoreService che la elimina, dopo di che
  ///viene notificato ai listeners l'eliminazione del documento
  quitSession() async {
    if (await hasSession()) {
      await FirestoreService.deleteSession(firebaseUser.user.uid);
    }
    notifyListeners();
  }

  ///Restituisce true se è presente una sessione per l'utente attuale, false
  ///altrimenti.
  ///Esegue il metodo sessionDocument di firestore service con id corrispondente
  ///all'id dell'utente firebase attuale, restituisce l'attributo 'exist' di questo
  ///documento
  Future<bool> hasSession() async {
    DocumentSnapshot doc =
        await FirestoreService.sessionDocument(firebaseUser.user.uid);
    return doc.exists;
  }

  // Define that two user are equals if userCode is
  bool operator ==(other) {
    return (other is RcaUser &&
        other.userCode == userCode &&
        other.firebaseUser == firebaseUser);
  }

  @override
  int get hashCode => 31 * userCode.hashCode;
}

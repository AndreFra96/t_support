import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:support/models/message.dart';
import 'package:support/models/rca_location.dart';
import 'package:support/models/rca_user.dart';

class FirestoreService {
  ///Crea un nuovo documento nella collezione user id corrispondente all'id dell'utente
  ///firebase connesso con i dati dell'RcaUser in input, questo documento serve
  ///a creare una connessione permanente ed eventualmente modificabile fra un dispositivo
  ///e un cliente di rca, questo documento viene utilizzato come contenitore principale per i
  ///dati dei clienti e non viene cancellato al termine della sessione
  static createFirestoreUserFromRcaUser(RcaUser user) async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser.user.uid);
    userRef.set({
      "customer_id": user.userCode,
      "piva": user.piva,
      "ragsoc": user.ragsoc
    });
    user.locations.forEach((key, value) {
      userRef.collection('location').doc(key).set(value.toMap());
    });
  }

  ///Modifica la location attiva nella sessione
  static updateSessionActiveLocation(String sessionID, String locationID) {
    FirebaseFirestore.instance
        .collection('sessions')
        .doc(sessionID)
        .set({'active_location': locationID}, SetOptions(merge: true));
  }

  ///Se esiste un documento nella collezione user con id corrispondente all'id
  ///dell'utente firebase in in input, allora viene inizializzato e restituito un
  ///RcaUser con i dati contenuti nella collezione. Se il documento non esiste
  ///viene inizializzato e restituito un RcaUser contentente solo l'informazione
  ///relativa all'utente firebase collegato
  static Future<RcaUser> createRcaUserFromFirestoreUser(
      UserCredential user) async {
    DocumentSnapshot s = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.user.uid)
        .get();
    //TODO: inizializza RcaUser con i dati ottenuti in s
    return new RcaUser(firebaseUser: user);
  }

  ///Inizializza una sessione per l'utente attuale su firebase, una sessione è
  ///una collezione contenuta nella collezione 'sessions' che ha id corrispondente
  ///all'id dell'utente firebase attualmente connesso. Per ogni utente attualmente
  ///loggato all'interno dell'applicazione esiste una sessione, l'accesso o meno
  ///di un dispositivo all'applicazione dipende dalla presenza di un documento
  ///di sessione per l'utente attuale che consente di creare una relazione stabile
  ///fra utente firebase e cliente rca all'interno della sessione
  static Future initSession(String userCode, String customerId, String piva,
      String ragsoc, Map<String, RcaLocation> location) async {
    DocumentReference doc =
        FirebaseFirestore.instance.collection('sessions').doc(userCode);
    await deleteSession(userCode);

    doc.set({"customer_id": customerId, "piva": piva, "ragsoc": ragsoc});
    location.forEach((key, value) {
      doc.collection('location').doc(key).set(value.toMap());
    });
    return;
  }

  ///restituisce il documento di sessione con id corrispondente a quello inserito
  ///in input, l'id in input deve essere l'id dell'utente firebase attualmente
  ///connesso
  static Future<DocumentSnapshot> sessionDocument(String docId) {
    return FirebaseFirestore.instance.collection('sessions').doc(docId).get();
  }

  ///Resituisce una lista di RcaLocation estratta dalla sessione attuale
  static Future<Map<String, RcaLocation>> sessionLocations(String docId) async {
    Map<String, RcaLocation> location = new Map<String, RcaLocation>();
    QuerySnapshot q = await FirebaseFirestore.instance
        .collection("sessions")
        .doc(docId)
        .collection('location')
        .get();

    q.docs.forEach((element) {
      location.putIfAbsent(
          element.id, () => RcaLocation.fromMap(element.data()));
    });

    return location;
  }

  ///restituisce uno stream sulla sessione con id corrispondente a quello inserito
  ///in input, l'id in input deve essre l'id dell'utente firebase attualmente
  ///connesso. Questo metodo deve essere utilizzato per stabilire se l'utente
  ///firebase che attualmente è connesso all'app ha effettuato il login o se
  ///deve effettuarlo.
  static Stream<DocumentSnapshot> sessionStream(String docId) {
    return FirebaseFirestore.instance
        .collection('sessions')
        .doc(docId)
        .snapshots();
  }

  ///elimina la sessione con id corrispondente a quello inserito in input, l'id
  ///in input deve essere l'id dell'utente firebase attualmente connesso.
  ///Questo metodo comporta il logout dell'utente firebase dall'app
  static Future<void> deleteSession(String sessionid) async {
    DocumentReference doc =
        FirebaseFirestore.instance.collection('sessions').doc(sessionid);
    QuerySnapshot snap = await doc.collection('location').get();
    snap.docs.forEach((element) {
      doc.collection('location').doc(element.id).delete();
    });
    doc.delete();
    return;
  }

  static sendHello(RcaUser user) async {
    DocumentReference doc = FirebaseFirestore.instance
        .collection('conversations')
        .doc(user.userCode);

    await doc
        .collection('messages')
        .add(Message(incoming: true, content: "Ciao, " + user.ragsoc).toMap());
  }

  static Stream<QuerySnapshot> fetchMessages(RcaUser user) {
    return FirebaseFirestore.instance
        .collection('conversations')
        .doc(user.userCode)
        .collection('messages')
        .snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class LaundryDatabase {
  // Access the 'laundry' collection in your cloud database
  final CollectionReference laundryCollection =
      FirebaseFirestore.instance.collection('laundry');

  // ADMIN: Add a new tag to the cloud
  Future<void> addTag(String tag) async {
    // Check if it already exists to prevent duplicates
    final snapshot = await laundryCollection.where('tag', isEqualTo: tag).get();
    if (snapshot.docs.isEmpty) {
      await laundryCollection.add({
        'tag': tag,
        'status': 'Ready',
        'isReady': true,
        'timestamp': FieldValue.serverTimestamp(), // Saves the exact time
        'dateString': "Today",
      });
    }
  }

  // ADMIN: Mark as Collected (Update the cloud status)
  Future<void> markAsCollected(String docId) async {
    await laundryCollection.doc(docId).update({
      'status': 'Collected',
      'isReady': false,
    });
  }

  // STUDENT: Listen for their specific tag (Live Stream)
  Stream<QuerySnapshot> getStudentStatus(String tag) {
    return laundryCollection.where('tag', isEqualTo: tag).snapshots();
  }

  // ADMIN/HISTORY: Listen to the whole list (Live Stream)
  Stream<QuerySnapshot> getFullHistory() {
    return laundryCollection.orderBy('timestamp', descending: true).snapshots();
  }
}


extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference usersListRef(String userId) =>
      collection('lists').doc(userId).collection('userList');
}

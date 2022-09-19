import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../constants.dart';

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});

  factory Question.fromMap(dynamic fieldData) {
    return Question(
        id: fieldData['id'],
        answer: fieldData['answer'],
        question: fieldData['question'],
        options: fieldData['options']);
  }
}

List sample_data = [
];



List loadedList = [];

Future<void> fetchAndSetList() async {
  await FirebaseFirestore.instance.collection("questions").get().then(
        (QuerySnapshot snapshot) => snapshot.docs.forEach(
            (f) => loadedList.map(
              (question) => Question(
              id: f.data()['id'],
              question: f.data()['question'],
              answer: f.data()['answer_index'],
              options: [f.data()['options']]
          ),
        ).toList()
    ),
  );
}



Future<void> fetchQues() async {
  final User user = await FirebaseAuth.instance.currentUser!;
  FirebaseFirestore.instance
      .collection('questions')
      .get()
      .then((QuerySnapshot? querySnapshot) {
    querySnapshot!.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      //sample_data.add(Question(id: doc['id'], question: doc['question'], answer: doc['answer_index'], options: List.from(doc['options'])));
      //  print("getData = ${doc["item_text_"]}");
      //qu = data['question'];
      //id = doc.data()['id'];
     // ans = doc.data()['answer_index'];
      //opt = List.from(doc.data()['options']);
    });
  }).catchError((e) {
    print(e);
  });
}
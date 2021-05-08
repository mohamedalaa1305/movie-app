import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/Person..dart';

import '../Constants.dart';
import '../Helper.dart';

class PersonController with ChangeNotifier {
  Person person;
  void downloadPerson(String id) async {
    person = new Person(id: id);
    var response = await api.getDetails(id, 'person');
    person = toPerson(response);
    notifyListeners();
  }

  Future<void> downloadCredits() async {
    await person.getCredits();
    notifyListeners();
  }

  Future<void> downloadImages() async {
    await person.getImages();
    notifyListeners();
  }
}

import 'package:culture_flutter_client/services/dummy_service.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

import 'festival_view_model.dart';

class MainListViewModel extends ChangeNotifier {

  List<FestivalViewModel> festivals = <FestivalViewModel>[];

  List<FestivalViewModel> favorites = <FestivalViewModel>[];

  @override void dispose() {} /* Prevent this view model from disposing */

  void selfDispose() {
    super.dispose();
  }

  Future<void> update() async {
    // TODO: Update festival list from remote
    final results = await DummyService.fetch();
    festivals = results.mapIndexed((i, e) => FestivalViewModel(id: i, model: e)).toList();
    notifyListeners();
  }

  void addFavorite(FestivalViewModel fest) {
    if (favorites.contains(fest)) {
      return;
    }
    favorites.add(fest);
    notifyListeners();
  }

  void removeFavorite(FestivalViewModel fest) {
    favorites.remove(fest);
    notifyListeners();
  }

  List<FestivalViewModel> randomFestivals(int count) {
    if (festivals.isEmpty) {
      update();
    }
    List<FestivalViewModel> copyOfFestivals = List.from(festivals);
    copyOfFestivals.shuffle();
    if (count > copyOfFestivals.length) {
      return copyOfFestivals;
    } else {
      return copyOfFestivals.take(count).toList();
    }
  }

  Future<void> updateAnimated(ScrollController scrollController) async {
    update();
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }
}
import 'package:culture_flutter_client/view_models/main_list_view_model.dart';
import 'package:culture_flutter_client/widgets/fab.dart';
import 'package:culture_flutter_client/widgets/festival_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/festival_list.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MainListViewModel>(context, listen: false).update();
  }

  @override
  Widget build(BuildContext context) {
    const int carouselCount = 4;

    final vm = Provider.of<MainListViewModel>(context);
    final carousel = FestivalCarousel(festivals: vm.randomFestivals(carouselCount));
    return Scaffold(
        appBar: AppBar(
            title: const Text("Welcome to Festival Culture")
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Expanded(child: carousel.carouselSlider),
              Expanded(child: Column(
                children: [
                  Row(children: [
                    Expanded(child: TextButton(onPressed: () => context.go("/list"),
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(child: Text('Festivals'))
                    ))),
                    Expanded(child: TextButton(onPressed: () => context.go("/map"),
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(child: Text('Map')),
                    ))),
                  ]),
                  Row(children: [
                    Expanded(child: TextButton(onPressed: () => context.go("/fav"),
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(child: Text('My Favorites')),
                    ))),
                    Expanded(child: TextButton(onPressed: () {  },
                    child: const SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(child: Text('Settings')),
                    ))),
                  ])
                ],
              ))
            ])
        )
    );
  }
}

class WelcomeScreenEntry extends StatefulWidget {
  const WelcomeScreenEntry({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Welcome to Festival Culture";

  @override
  State<WelcomeScreenEntry> createState() => _WelcomeScreenEntryState();
}

class _WelcomeScreenEntryState extends State<WelcomeScreenEntry> {

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MainListViewModel>(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => vm,
        child: const WelcomeScreen(),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const NavigationFab(currentPageType: PageType.welcome)
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for using json.decode()
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          theme: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.blue.shade400)),
          title: 'LivCard Info',
          home: HomePage(),
        ));
  }
}

class MyAppState extends ChangeNotifier {
  Map<String, dynamic> cards = {
    "1": {
      "checkouts": [
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            renewCount: 0,
            dueDate: DateTime.now()),
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            renewCount: 0,
            dueDate: DateTime.now())
      ],
      "holds": [
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now()),
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now())
      ]
    },
    "2": {
      "checkouts": [
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/fe0321",
            renewCount: 0,
            dueDate: DateTime.now()),
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/fe0321",
            renewCount: 0,
            dueDate: DateTime.now())
      ],
      "holds": [
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now()),
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now())
      ]
    },
    "3": {
      "checkouts": [
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/defe32",
            renewCount: 0,
            dueDate: DateTime.now()),
        CheckoutBook(
            dclID: 0,
            title: "Title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/defe32",
            renewCount: 0,
            dueDate: DateTime.now())
      ],
      "holds": [
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now()),
        HoldBook(
            dclID: 1,
            title: "title",
            author: "author",
            imgURL: "https://via.placeholder.com/300/ffee00",
            available: true,
            pickupDate: DateTime.now())
      ]
    }
  };
  bool getOverdue(List<CheckoutBook> thisCardCheckouts, index) {
    return !thisCardCheckouts[index].dueDate.isAfter(DateTime.now());
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const PageLadderHome();
        break;
      case 1:
        page = PageLadderCard("1");
        break;
      case 2:
        page = PageLadderCard("2");
        break;
      case 3:
        page = PageLadderCard("3");
        break;
      default:
        throw UnimplementedError("No widget for $selectedIndex");
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        bottomNavigationBar: constraints.maxWidth < 500
            ? NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.credit_card),
                      label: 'Card 1',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.credit_card),
                      label: 'Card 2',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.credit_card),
                      label: 'Card 3',
                    )
                  ])
            : null,
        body: Row(
          children: [
            SafeArea(
              child: constraints.maxWidth >= 500
                  ? NavigationRail(
                      extended: constraints.maxWidth >= 800,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.credit_card),
                          label: Text('Card 1'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.credit_card),
                          label: Text('Card 2'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.credit_card),
                          label: Text('Card 3'),
                        ),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                    )
                  : Container(),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PageLadderHome extends StatelessWidget {
  const PageLadderHome({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    var appState = context.watch<MyAppState>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "LivCard Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageLadderCard extends StatelessWidget {
  String cardNumber;
  PageLadderCard(this.cardNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List<CheckoutBook> thisCardCheckouts =
        appState.cards[cardNumber]["checkouts"];
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Card $cardNumber Title",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            // BODY
            thisCardCheckouts.isEmpty
                ? const Text("Error Message Here")
                : Expanded(
                    child: ListView.builder(
                      itemCount: thisCardCheckouts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Card(
                          child: Row(
                            children: [
                              Image.network(
                                thisCardCheckouts[index].imgURL,
                                fit: BoxFit.fill,
                                height: 150,
                                width: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      thisCardCheckouts[index].title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(thisCardCheckouts[index].author),
                                    Text(
                                        "Item Barcode: ${thisCardCheckouts[index].dclID}")
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: appState.getOverdue(
                                        thisCardCheckouts, index)
                                    ? Icon(
                                        Icons.error_outline,
                                        color: Colors.red.shade400,
                                      )
                                    : Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green.shade400,
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(DateFormat("yMMMMd").format(
                                        thisCardCheckouts[index].dueDate))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
    ;
  }
}

class Book {
  final int dclID;
  final String title;
  final String author;
  final String imgURL;
  Book({
    required this.dclID,
    required this.title,
    required this.author,
    required this.imgURL,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        dclID: int.parse(json['dcl_id']),
        title: json['title'],
        author: json['author'],
        imgURL: json['img_url']);
  }
}

class CheckoutBook extends Book {
  final int renewCount;
  final DateTime dueDate;
  CheckoutBook({
    required super.dclID,
    required super.title,
    required super.author,
    required super.imgURL,
    required this.renewCount,
    required this.dueDate,
  });
  factory CheckoutBook.fromJson(Map<String, dynamic> json) {
    return CheckoutBook(
        dclID: int.parse(json['dcl_id']),
        title: json['title'],
        author: json['author'],
        renewCount: int.parse(json['renew_count']),
        dueDate: DateTime.parse(json['due_date']),
        imgURL: json['img_url']);
  }
}

class HoldBook extends Book {
  final bool available;
  final DateTime pickupDate;
  HoldBook({
    required super.dclID,
    required super.title,
    required super.author,
    required super.imgURL,
    required this.available,
    required this.pickupDate,
  });
  factory HoldBook.fromJson(Map<String, dynamic> json) {
    return HoldBook(
        dclID: int.parse(json['dcl_id']),
        title: json['title'],
        author: json['author'],
        available: (json['available']) as bool,
        pickupDate: DateTime.parse(json['pickup_date']),
        imgURL: json['img_url']);
  }
}

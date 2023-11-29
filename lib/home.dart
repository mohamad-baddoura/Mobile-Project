import 'package:emoji_app/AdvancedMode.dart';
import 'package:emoji_app/CategoriesPages/activities&music.dart';
import 'package:emoji_app/CategoriesPages/animals.dart';
import 'package:emoji_app/CategoriesPages/flags.dart';
import 'package:emoji_app/CategoriesPages/food&drinks.dart';
import 'package:emoji_app/CategoriesPages/smileys&people.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/MainPage.jpeg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //Center the buttons vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              //Center the buttons horizontally

              children: [
                SizedBox(
                  width: 200,
                  height: 65,
                  //floating button #1
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showOptionDialog(context);
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Game',
                        style: TextStyle(fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.greenAccent.shade700.withOpacity(
                        0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //floating button #2
                SizedBox(
                  width: 200,
                  height: 65,
                  //floating button #1
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(context: context, builder: (context) =>
                          showAboutGame(),);
                    },
                    icon: const Icon(Icons.info),
                    label: const Text('About Game',
                        style: TextStyle(fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.greenAccent.shade700.withOpacity(
                        0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //floating button #3
                SizedBox(
                  width: 150,
                  height: 65,
                  //floating button #1
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      exit(0); //closes the app
                    },
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('Exit',
                        style: TextStyle(fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.greenAccent.shade700.withOpacity(
                        0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget showAboutGame() {
    return AlertDialog(
      title: const Text('About the Game!'),
      content: const Text(
          'In this game you have the option to choose among two levels.\n'
              '1. Normal Mode: You should guess 10 normal emojis to win the game.\n'
              '2. Advanced Mode: You should guess 10 emojis(each is a combination of 2 or 3 emojis) to win the game.\n'
      ),
      actions: [
        TextButton(child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            }
        )
      ],
    );
  }

  //Difficulty category:
  List<String> options = ['Normal', 'Advanced 🧠'];

  void showOptionDialog(BuildContext context) {
    //variable to store the selected option
    String selectedOption = options[0];
    //show the category dialog
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(249, 195, 9, 1.0),
        contentPadding: const EdgeInsets.all(0),
        title: const Text('Choose Difficulty Option:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      options.length,
                          (index) =>
                          RadioListTile(
                            title: Text(options[index]),
                            value: options[index],
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value!;
                              }); //setState
                            }, //onChanged
                            fillColor: MaterialStateColor.resolveWith((states){
                              if (states.contains(MaterialState.selected)) {
                                return Colors.greenAccent.shade700; // the color for selected radio button
                              } else {
                                return Colors.white; // the color for unselected radio button
                              }
                            }),
                          ),
                    ),
                  )
              );
            } //builder
        ),
        actions: [
          FloatingActionButton.extended(
            backgroundColor: Colors.greenAccent.shade700,
            label:  const Icon(Icons.arrow_circle_right_outlined),
            icon: const Text('Continue'),
            onPressed: () { //do something
              //close the dialog
              Navigator.of(context).pop();
              if(selectedOption == 'Normal') {
                showCategoryDialog(context);
              }
              else{
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdvancedGame())
                );
              }
            }, //onPressed
          ),
        ], //actions
      );
    }); //showDialog
  } //showOptionDialog


//categories list:
  List<String> categories = [
    'Smileys & People',
    'Animals',
    'Food & Drink',
    'Activities & Music',
    'Countries Flags'
  ];

  void showCategoryDialog(BuildContext context) {
    //variable to store the selected category
    String selectedCategory = categories[0];

    //show the category dialog
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.green.shade700,
        title: const Text('Choose a Category: ',
            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  categories.length,
                      (index) =>
                      RadioListTile(
                        title: Text(categories[index]),
                        value: categories[index],
                        groupValue: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          }); //setState
                        }, //onChanged
                        fillColor: MaterialStateColor.resolveWith((states){
                          if (states.contains(MaterialState.selected)) {
                          return const Color.fromRGBO(249, 195, 9, 1.0); // the color for selected radio button
                          } else {
                          return Colors.white; // the color for unselected radio button
                          }
                        }),
                      ),
                ),
              )
              );
            } //builder
        ),
        actions: [
         FloatingActionButton.extended(
           backgroundColor: const Color.fromRGBO(249, 195, 9, 1.0),
            label:  const Icon(Icons.arrow_circle_right_outlined),
            icon: const Text('Continue'),
            onPressed: () { //do something
              //close the dialog
              Navigator.of(context).pop();
              //navigate to the selected category page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => getSelectedCategoryPage(selectedCategory)),
              );
            }, //onPressed
          ),
        ], //actions
      );
    }); //showDialog
  } //showCategoryDialog

  Widget getSelectedCategoryPage(String selectedCategory){
    switch(selectedCategory){
      case 'Smileys & People':
        return const SmileysEmojiGame();
      case 'Animals':
        return const AnimalsEmojiGame();
      case 'Food & Drink':
        return const FoodEmojiGame();
      case 'Activities':
        return const ActivitiesEmojiGame();
      case 'Countries Flags':
        return const FlagsEmojiGame();
      default:
        return const SmileysEmojiGame();
    }
  }
} //homeState

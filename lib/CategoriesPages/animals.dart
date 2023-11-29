import 'dart:math';
import 'package:emoji_app/home.dart';
import 'package:flutter/material.dart';
import 'package:emoji_app/emojiPacks.dart';
import 'package:flutter/services.dart';

// A stateful widget that displays the emoji game
class AnimalsEmojiGame extends StatefulWidget {
  // A constructor that takes a key parameter
  const AnimalsEmojiGame({Key? key}) : super(key: key);

  // A method that creates an instance of the EmojiGameState class
  @override
  _EmojiGameState createState() => _EmojiGameState();
}

// A state class that contains the logic and internal state of the emoji game widget
class _EmojiGameState extends State<AnimalsEmojiGame> {
  // Declare the variables that store the emoji, the text, the choices, the score, and the lives of the user
  String emoji = "";
  String text = "";
  List<String> choices = [];
  int score = 0;
  int lives = 3;
  //variable that counts the number of random emojis generated
  int counter = 0;
  //a constant that defines the limit of emojis
  int limit = 10;

  // A method that initializes the state of the widget
  @override
  void initState() {
    super.initState();
    // Get a random emoji and choices when the widget is first created
    String result = getRandomEmojiAndChoices();
    emoji = result.split("\n")[0];
    text = EmojiPacks().animalsMap[emoji]!;
    choices = result.split("\n").sublist(1);
    counter = 0;
  }

  Set<String> showEmojis = Set();
  // A method that returns a random emoji and three choices, one of which is correct
  String getRandomEmojiAndChoices() {
    // Create a list of all the keys (emojis) in the Map
    List<String> emojis = EmojiPacks().animalsMap.keys.toList();
    // Create a list of all the values (text descriptions) in the Map
    List<String> texts = EmojiPacks().animalsMap.values.toList();
    // Create a random number generator
    Random random = Random();
    // Pick a random index from 0 to the length of the emojis list
    int index = random.nextInt(emojis.length);
    // Get the emoji and the text description at that index
    String emoji = emojis[index];
    String text = texts[index];
    //check if the emoji is already in the shownEmojis set
    if (showEmojis.contains(emoji)) {
      return getRandomEmojiAndChoices();
    }
    else {
      showEmojis.add(emoji);
      // Create a list of three choices, one of which is the text description
      List<String> choices = [text];
      // Add two random wrong choices from the texts list
      while (choices.length < 3) {
        // Pick a random index from 0 to the length of the texts list
        int wrongIndex = random.nextInt(texts.length);
        // Get the text at that index
        String wrongText = texts[wrongIndex];
        // If the text is not already in the choices list, add it
        if (!choices.contains(wrongText)) {
          choices.add(wrongText);
        }
      }
      // Shuffle the choices list to randomize the order
      choices.shuffle();
      // Return a string that contains the emoji and the choices, separated by newlines
      return emoji + "\n" + choices.join("\n");
    }
  }

  // A method that handles the user input and updates the state
  void handleInput(String choice) {
    // Check if the choice is correct or wrong
    if (choice == text) {
      // If correct, increase the score by one
      setState(() {
        score = score+10;
      });
    } else {
      // If wrong, decrease the lives by one
      setState(() {
        lives--;
      });
    }
    // Check if the game is over or not
    if (lives == 0) {
      // If the lives are zero, show a dialog that displays the final score and a button to restart the game
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Game Over", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),),
            content: Text("Your final score is: $score"),
            actions: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnimalsEmojiGame()),
                  );
                }, child: const Text("Restart Game"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }
                  , child: Text("Return to Home"))
            ],backgroundColor: Colors.green.shade700,
          );
        },
      );
    } else {
      counter++;
      //check if counter reached the limit before getting new emoji
      if(counter < limit) {
        // If the lives are not zero, get a new emoji and choices
        setState(() {
          String result = getRandomEmojiAndChoices();
          emoji = result.split("\n")[0];
          text = EmojiPacks().animalsMap[emoji]!;
          choices = result.split("\n").sublist(1);
        });
      }
      else{
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Game Over", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),),
              content: Text("Your final score is: $score"),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AnimalsEmojiGame()),
                    );
                  }, child: const Text("Restart Game"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }
                    , child: Text("Return to Home"))
              ],backgroundColor: Colors.green.shade700,
            );
          },
        );
      }
    }
  }

  // A method that builds the widget tree
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return a scaffold widget that contains the app bar, the body, and the bottom navigation bar of the app
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/emojis(animals).jpeg')
                ,fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // The app bar that displays the title of the app
          appBar: AppBar(
            title:
            Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // A text widget that displays the score
                      Text(
                        "Score: $score",
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      // A text widget that displays the lives
                      Text(
                        "Lives: ♥$lives",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Text('${limit - counter} emojis left to win the game!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                ]),
            backgroundColor: Colors.green.shade700,
          ),
          // The body that displays the emoji, the choices, the score, and the lives of the user
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                // A text widget that displays the emoji
                Container(
                    width: 270,
                    height: 170,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      emoji,
                      style: TextStyle(fontSize: 50),
                    )),
                SizedBox(
                  height: 30,
                ),
                // A row widget that displays the three choices as buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // A button that displays the first choice
                    SizedBox(
                        width: 230,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // When the button is pressed, call the handleInput method with the first choice as the parameter
                            handleInput(choices[0]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              )
                          ),
                          child: Text(choices[0],
                              style: const TextStyle(fontSize: 15)),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    // A button that displays the second choice
                    SizedBox(
                        width: 230,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // When the button is pressed, call the handleInput method with the first choice as the parameter
                            handleInput(choices[1]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              )
                          ),
                          child: Text(choices[1],
                              style: const TextStyle(fontSize: 15)),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    // A button that displays the third choice
                    SizedBox(
                        width: 230,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // When the button is pressed, call the handleInput method with the first choice as the parameter
                            handleInput(choices[2]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              )
                          ),
                          child: Text(choices[2],
                              style: const TextStyle(fontSize: 15)),
                        )),
                  ],
                ),
                // A row widget that displays the score and the lives of the user

              ],
            ),
          ),
          bottomNavigationBar: Container(
              color: Colors.red.withOpacity(
                  0.8),
              height: 30,
              child: const Text(
                'Animals',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
        ));
  }
}





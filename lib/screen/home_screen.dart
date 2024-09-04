import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screen/game_screen.dart';
import 'package:tic_tac_toe_game/utils/color_constrants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text Fields Controllers
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConst.primaryColor,
        title: const Text('Home Screen', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('Select Your player', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white)),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: player1Controller,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Please Enter player 1 name';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white), // Set input text color to white
                    decoration: InputDecoration(
                      hintText: 'Player 1 Name',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: player2Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter player 2 name';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white), // Set input text color to white
                    decoration: InputDecoration(
                      hintText: 'Player 2 Name',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 50),
                  
                  // Start Game button 
                  InkWell(
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen(player1: player1Controller.text, player2: player2Controller.text),));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: const Text('Start Game', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

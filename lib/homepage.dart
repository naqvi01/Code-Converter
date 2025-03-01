import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  String? selectedValues;

  String _response = "Enter a Code and click generate.";
  String defaultString =
      "Direct give the answer without any other things like greeating or something else and also if there is something other than Code in any language like asking a general Question or any type of technical or professional question than simply answer that 'This is not any Code. Write a Code to Convert.', also dont give anything like title or something else . \n Convert the below code to    ";

  Future<void> getGeminiResponse(String prompt) async {
    setState(() {
      _response = "Generating response...";
    });
    if (selectedValues == null) {
      setState(() {
        _response = "Please select an option from the dropdown.";
      });
      return;
    }
    String fullPrompt = " $defaultString $selectedValues \n $prompt";
    final result = await Gemini.instance.prompt(parts: [Part.text(fullPrompt)]);

    setState(() {
      _response = result?.output ?? "No response.";
    });
  }

  final List<String> items = [
    "C",
    "C++",
    "Java",
    "Python",
    "JavaScript",
    "Go",
    "Rust",
    "Swift",
    "Kotlin",
    "HTML",
    "CSS",
    "TypeScript",
    "PHP",
    "Ruby",
    "Bash",
    "Perl",
    "Lua",
    "SQL",
    "PL/SQL",
    "GraphQL",
    "Haskell",
    "Lisp",
    "Clojure",
    "F#",
    "Assembly",
    "Machine Code",
    "MATLAB",
    "R",
    "VHDL",
    "Brainfuck",
    "LOLCODE",
    "INTERCAL",
    "BhaiLang"
  ];

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Code Converter",
          style: GoogleFonts.silkscreen(fontSize: 50),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Enter Code Here",
                      style: GoogleFonts.silkscreen(fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Positioned(
                        top: 7,
                        right: 7,
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: _controller,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "Write Code Here.",
                              hintStyle: GoogleFonts.silkscreen(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                value: selectedValues, // Current selected value
                hint: Text(
                  "Select a Language",
                  style: GoogleFonts.silkscreen(color: Colors.white),
                ), // Default text
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.shadowsIntoLight(
                          fontWeight: FontWeight.bold, letterSpacing: 3),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValues = newValue; // Update selected value
                  });
                },
              ),

              Column(
                children: [
                  Text(
                    "Output",
                    style: GoogleFonts.silkscreen(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Positioned(
                        top: 7,
                        right: 7,
                        child: Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SingleChildScrollView(
                              child: SelectableText(
                                _response,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // Expanded(
              //   child: Container(
              //     height: 500,
              //     decoration: BoxDecoration(
              //         color: Colors.amber,
              //         borderRadius: BorderRadius.circular(20)),
              //   ),
              // )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPressed = false;
              });
              if (_controller.text.isNotEmpty) {
                getGeminiResponse(_controller.text);
              }
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            // onTap: () {
            //   if (_controller.text.isNotEmpty) {
            //     getGeminiResponse(_controller.text);
            //   }
            // },
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    transform: _isPressed
                        ? Matrix4.translationValues(3, -4, 2)
                        : Matrix4.identity(),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        boxShadow: _isPressed
                            ? []
                            : [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 5)
                              ],
                        color: Colors.amber,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "Generate",
                        style: GoogleFonts.silkscreen(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

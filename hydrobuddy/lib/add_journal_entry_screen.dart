import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'journal_screen.dart';

class AddJournalEntryScreen extends StatefulWidget {
  const AddJournalEntryScreen({super.key});

  @override
  _AddJournalEntryScreenState createState() => _AddJournalEntryScreenState();
}

class _AddJournalEntryScreenState extends State<AddJournalEntryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff96b9d0),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _glassmorphicTextField(
                    titleController, 'Title', 50.0), // Height is 50.0
                SizedBox(height: 20),
                _glassmorphicTextField(
                    contentController, 'Content', 300.0), // Height is 100.0
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    imageProvider =
                        const NetworkImage('https://via.placeholder.com/150');
                    setState(() {});
                  },
                  child: const Text('Add Photo'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                contentController.text.isNotEmpty &&
                imageProvider != null) {
              Navigator.pop(
                  context,
                  JournalEntry(titleController.text, DateTime.now(),
                      contentController.text, imageProvider!));
            }
          },
          child: const Icon(Icons.check),
          backgroundColor: Color(0xffbfd4db),
        ));
  }

  Widget _glassmorphicTextField(TextEditingController controller, String label,
      [double height = 50.0]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GlassmorphicContainer(
        width: 450,
        height: height, // Use the height parameter here
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.1),
            ],
            stops: [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

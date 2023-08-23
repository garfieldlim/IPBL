import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Add Entry')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                // For this demonstration, just using a placeholder image.
                // In a real scenario, you'd integrate an image picker.
                imageProvider = const NetworkImage('https://via.placeholder.com/150');
                setState(() {});
              },
              child: const Text('Add Photo'),
            ),
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            Expanded(
                child: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(labelText: 'Content'),
                    maxLines: null)),
          ],
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
                  contentController.text, imageProvider!),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hydrobuddy/add_journal_entry_screen.dart';

class JournalEntry {
  final String title;
  final DateTime date;
  final String content;
  final ImageProvider image;

  JournalEntry(this.title, this.date, this.content, this.image);
}

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<JournalEntry> entries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journal')),
      body: GridView.builder(
        itemCount: entries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return Card(
            child: Column(
              children: [
                Image(image: entry.image, fit: BoxFit.cover),
                Text(entry.title),
                Text(entry.date
                    .toLocal()
                    .toString()
                    .split(' ')[0]), // Only show YYYY-MM-DD format
                Expanded(
                    child: SingleChildScrollView(child: Text(entry.content))),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add a new entry (can be a new page or a dialog)
          final newEntry = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddJournalEntryScreen(),
            ),
          );

          if (newEntry != null) {
            setState(() {
              entries.add(newEntry);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

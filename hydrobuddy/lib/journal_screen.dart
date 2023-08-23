import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class JournalEntry {
  final String title;
  final DateTime date;
  final String content;
  final ImageProvider<Object> image;
  final String imageUrl; // Add this

  JournalEntry(this.title, this.date, this.content, this.image,
      this.imageUrl); // Update this
}

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<JournalEntry> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEntries = prefs.getStringList('journalEntries') ?? [];
    setState(() {
      entries = storedEntries.map((entryStr) {
        final split = entryStr.split('|||');
        return JournalEntry(split[0], DateTime.parse(split[1]), split[2],
            NetworkImage(split[3]), split[3] // Pass the image URL here
            );
      }).toList();
    });
  }

  _storeEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entryStrs = entries
        .map((entry) =>
                '${entry.title}|||${entry.date.toIso8601String()}|||${entry.content}|||${entry.imageUrl}' // Use imageUrl here
            )
        .toList();

    prefs.setStringList('journalEntries', entryStrs);
  }

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
                Text(entry.date.toLocal().toString().split(' ')[0]),
                Expanded(
                  child: SingleChildScrollView(child: Text(entry.content)),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEntry = await Navigator.push<JournalEntry>(
            context,
            MaterialPageRoute(builder: (context) => AddJournalEntryScreen()),
          );

          if (newEntry != null) {
            setState(() {
              entries.add(newEntry);
            });
            _storeEntries();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddJournalEntryScreen extends StatefulWidget {
  @override
  _AddJournalEntryScreenState createState() => _AddJournalEntryScreenState();
}

class _AddJournalEntryScreenState extends State<AddJournalEntryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  ImageProvider? imageProvider;
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

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
                final pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    _selectedImage = pickedImage;
                    imageProvider = FileImage(File(_selectedImage!.path));
                  });
                }
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
              JournalEntry(
                  titleController.text,
                  DateTime.now(),
                  contentController.text,
                  imageProvider!,
                  _selectedImage!.path), // Add the image path here
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please fill in all fields.')),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

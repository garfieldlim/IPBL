import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  List<Achievement> achievements = [
    Achievement(title: "Green Thumb", description: "Plant your first seed."),
    Achievement(
        title: "A Growing Journey", description: "Harvest your first plant."),
    Achievement(
        title: "Hydro Hero",
        description: "Setup your first hydroponic system."),
    Achievement(
        title: "Garden Guru",
        description: "Grow 10 different types of plants."),
    Achievement(
        title: "Conservationist",
        description: "Recycle water in your hydroponic system."),
    Achievement(
        title: "Tech Gardener", description: "Automate watering using IoT."),
    Achievement(
        title: "Light Bringer",
        description: "Implement an LED lighting system for your plants."),
    Achievement(
        title: "Pest Hunter",
        description:
            "Successfully repel pests without using harmful chemicals."),
    Achievement(
        title: "Organic Master",
        description: "Grow a plant using only organic nutrients."),
    Achievement(
        title: "Water Whisperer",
        description: "Successfully grow a plant using only water."),
    Achievement(
        title: "Green Streak",
        description: "Take care of your plants daily for 30 days straight."),
    Achievement(
        title: "Plant Parent",
        description: "Grow and sustain 5 plants simultaneously."),
    Achievement(
        title: "Budding Biologist",
        description: "Experiment with two different growing mediums."),
    Achievement(
        title: "Nutrient Ninja",
        description: "Custom mix nutrients for optimal plant growth."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.emoji_events_outlined, color: Colors.green),
            title: Text(achievements[index].title),
            subtitle: Text(achievements[index].description),
          );
        },
      ),
    );
  }
}

class Achievement {
  final String title;
  final String description;

  Achievement({required this.title, required this.description});
}

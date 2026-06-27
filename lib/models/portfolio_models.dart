import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final Color accentColor;
  final String emoji;
  final String githubUrl;
  final String? liveUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    required this.accentColor,
    required this.emoji,
    required this.githubUrl,
    this.liveUrl,
  });
}

class SkillModel {
  final String name;
  final double level; // 0.0 to 1.0
  final Color color;
  final IconData icon;

  const SkillModel({
    required this.name,
    required this.level,
    required this.color,
    required this.icon,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;
  final Color color;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.color,
  });
}

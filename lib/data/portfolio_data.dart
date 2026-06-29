import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';

class PortfolioData {
  static const String name = 'Mohamed Sabry';
  static const String title = 'Flutter Developer';
  static const String tagline = 'Crafting beautiful cross-platform experiences with Flutter & Dart';
  static const String bio =
      'Passionate Flutter developer with 4+ years building production apps. '
      'I love pixel-perfect UIs, smooth animations, and clean architecture. '
      'From zero to app store — I ship products that users love.';

  static const String email = 'mohamed@flutterdev.io';
  static const String github = 'https://github.com/mohamedsabry';
  static const String linkedin = 'https://linkedin.com/in/mohamedsabry';
  static const String twitter = 'https://twitter.com/mohamedsabry';

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'NovaPay Wallet',
      description:
          'A fintech super-app with real-time crypto & fiat wallet management. '
          'Built with BLoC architecture, WebSocket streams, and custom chart animations.',
      tags: ['Flutter', 'BLoC', 'WebSocket', 'Crypto', 'Firebase'],
      accentColor: AppTheme.cyan,
      emoji: '💳',
      githubUrl: 'https://github.com/mohamedsabry/novapay',
      liveUrl: 'https://novapay.app',
    ),
    ProjectModel(
      title: 'Orbit — Habit Tracker',
      description:
          'Minimalist habit tracker with gamified streaks, custom 2D planet animations, '
          'and offline-first architecture using Isar DB.',
      tags: ['Flutter', 'Isar DB', 'Riverpod', 'Animations', 'iOS & Android'],
      accentColor: AppTheme.green,
      emoji: '🪐',
      githubUrl: 'https://github.com/mohamedsabry/orbit',
      liveUrl: 'https://orbit-app.io',
    ),
    ProjectModel(
      title: 'FlowMeet — Video Calls',
      description:
          'WebRTC-powered video calling app with virtual backgrounds, screen sharing, '
          'and real-time whiteboard. 50k+ downloads on Play Store.',
      tags: ['Flutter Web', 'WebRTC', 'GetX', 'Canvas', 'Node.js'],
      accentColor: AppTheme.purple,
      emoji: '🎥',
      githubUrl: 'https://github.com/mohamedsabry/flowmeet',
    ),
    ProjectModel(
      title: 'AgroSense — IoT Dashboard',
      description:
          'Real-time IoT dashboard for smart farming. Animated data visualizations, '
          'sensor graphs, and BLE device management.',
      tags: ['Flutter', 'BLE', 'MQTT', 'fl_chart', 'Provider'],
      accentColor: AppTheme.amber,
      emoji: '🌱',
      githubUrl: 'https://github.com/mohamedsabry/agrosense',
    ),
  ];

  static const List<SkillModel> skills = [
    SkillModel(
      name: 'Flutter & Dart',
      level: 0.95,
      color: AppTheme.cyan,
      icon: Icons.phone_android,
    ),
    SkillModel(
      name: 'State Management (BLoC / Riverpod)',
      level: 0.90,
      color: AppTheme.green,
      icon: Icons.account_tree,
    ),
    SkillModel(
      name: 'Custom Animations',
      level: 0.88,
      color: AppTheme.purple,
      icon: Icons.animation,
    ),
    SkillModel(
      name: 'Firebase & Supabase',
      level: 0.85,
      color: AppTheme.amber,
      icon: Icons.cloud,
    ),
    SkillModel(
      name: 'REST APIs & WebSockets',
      level: 0.87,
      color: AppTheme.cyan,
      icon: Icons.api,
    ),
    SkillModel(
      name: 'Flutter Web & Desktop',
      level: 0.80,
      color: AppTheme.green,
      icon: Icons.desktop_mac,
    ),
    SkillModel(
      name: 'CI/CD & App Store Deployment',
      level: 0.82,
      color: AppTheme.purple,
      icon: Icons.rocket_launch,
    ),
    SkillModel(
      name: 'Clean Architecture & TDD',
      level: 0.85,
      color: AppTheme.amber,
      icon: Icons.architecture,
    ),
  ];

  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Senior Flutter Developer',
      company: 'NovaTech Labs',
      period: '2022 — Present',
      description:
          'Led Flutter development for a team of 6. Shipped 3 production apps '
          'with 200k+ combined downloads. Introduced BLoC architecture and '
          'reduced app crash rate by 78%.',
      color: AppTheme.cyan,
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'ByteWave Studio',
      period: '2021 — 2022',
      description:
          'Built cross-platform apps for 12+ clients across fintech, healthcare, '
          'and e-commerce. Specialized in custom animations and performance optimization.',
      color: AppTheme.green,
    ),
    ExperienceModel(
      role: 'Mobile Developer',
      company: 'Freelance',
      period: '2020 — 2021',
      description:
          'Started Flutter journey. Delivered 8 apps independently — from design '
          'to deployment. Built strong foundations in Dart, state management, and UX.',
      color: AppTheme.purple,
    ),
  ];
}

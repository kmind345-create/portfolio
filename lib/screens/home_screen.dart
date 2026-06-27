import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../animations/particles_widget.dart';
import '../animations/widget_tree_animation.dart';
import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_skill_bar.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_timeline.dart';
import '../widgets/nav_bar.dart';
import '../widgets/project_card.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // Section keys for nav scroll
  final _heroKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  bool _skillsVisible = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sectionKeys = [
      _heroKey,
      _projectsKey,
      _skillsKey,
      _experienceKey,
      _contactKey,
    ];

    return Scaffold(
      backgroundColor: AppTheme.bgDeep,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _HeroSection(key: _heroKey),
                _ProjectsSection(key: _projectsKey),
                _SkillsSection(
                  key: _skillsKey,
                  onVisible: () => setState(() => _skillsVisible = true),
                  skillsVisible: _skillsVisible,
                ),
                _ExperienceSection(key: _experienceKey),
                ContactSection(key: _contactKey),
              ],
            ),
          ),
          // Sticky nav bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              scrollController: _scrollController,
              sectionKeys: sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── HERO ────────────────────────────

class _HeroSection extends StatefulWidget {
  const _HeroSection({super.key});

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      child: Stack(
        children: [
          // Particles background
          Positioned.fill(
            child: const ParticlesWidget(),
          ),

          // Radial gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.centerLeft,
                  radius: 1.2,
                  colors: [
                    AppTheme.cyan.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.fromLTRB(
              isWide ? 80 : 24,
              isWide ? 140 : 120,
              isWide ? 80 : 24,
              80,
            ),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 5, child: _HeroText()),
                      const SizedBox(width: 60),
                      Expanded(flex: 4, child: _HeroVisual(controller: _orbitController)),
                    ],
                  )
                : Column(
                    children: [
                      _HeroText(),
                      const SizedBox(height: 48),
                      SizedBox(
                        height: 360,
                        child: _HeroVisual(controller: _orbitController),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HI, I\'M',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 4,
                fontSize: 13,
              ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        const SizedBox(height: 12),
        Text(
          PortfolioData.name,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: MediaQuery.of(context).size.width > 900 ? 72 : 48,
              ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 700.ms)
            .slideX(begin: -0.15, end: 0, delay: 300.ms, duration: 700.ms),
        const SizedBox(height: 8),
        Row(
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 900 ? 28 : 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.cyan,
                  ),
                  speed: const Duration(milliseconds: 80),
                ),
                TypewriterAnimatedText(
                  'Dart Enthusiast',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 900 ? 28 : 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.green,
                  ),
                  speed: const Duration(milliseconds: 80),
                ),
                TypewriterAnimatedText(
                  'App Architect',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 900 ? 28 : 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.purple,
                  ),
                  speed: const Duration(milliseconds: 80),
                ),
                TypewriterAnimatedText(
                  'UI/UX Craftsman',
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 900 ? 28 : 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.amber,
                  ),
                  speed: const Duration(milliseconds: 80),
                ),
              ],
              repeatForever: true,
              pause: const Duration(milliseconds: 1800),
            ),
          ],
        ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
        const SizedBox(height: 20),
        Text(
          PortfolioData.tagline,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textMuted,
            height: 1.7,
          ),
        ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
        const SizedBox(height: 36),
        Row(
          children: [
            _HeroCTAButton(
              label: 'View Projects',
              isPrimary: true,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            _HeroCTAButton(
              label: 'Download CV',
              isPrimary: false,
              onTap: () {},
            ),
          ],
        ).animate().fadeIn(delay: 900.ms, duration: 600.ms),
        const SizedBox(height: 48),
        Row(
          children: [
            _StatBadge(value: '4+', label: 'Years'),
            const SizedBox(width: 32),
            _StatBadge(value: '200k+', label: 'Downloads'),
            const SizedBox(width: 32),
            _StatBadge(value: '20+', label: 'Apps'),
          ],
        ).animate().fadeIn(delay: 1100.ms, duration: 600.ms),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  final AnimationController controller;

  const _HeroVisual({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          // Glow background
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (_, __) => Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.cyan.withOpacity(0.07),
                      AppTheme.green.withOpacity(0.04),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Widget tree animation
          const Positioned.fill(
            child: WidgetTreeAnimation(),
          ),

          // Flutter logo badge in center
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.bgCard,
                border: Border.all(
                  color: AppTheme.cyan.withOpacity(0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.cyan.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Center(
                child: Text('💙', style: TextStyle(fontSize: 28)),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(
                  begin: 0.95,
                  end: 1.05,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 800.ms).scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1), delay: 600.ms, duration: 800.ms);
  }
}

class _HeroCTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroCTAButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroCTAButton> createState() => _HeroCTAButtonState();
}

class _HeroCTAButtonState extends State<_HeroCTAButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: _hovered
                        ? [AppTheme.cyan.withOpacity(0.9), AppTheme.green.withOpacity(0.9)]
                        : [AppTheme.cyan, AppTheme.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: widget.isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _hovered
                        ? AppTheme.cyan.withOpacity(0.6)
                        : AppTheme.textMuted.withOpacity(0.3),
                  ),
            boxShadow: widget.isPrimary && _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.cyan.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.isPrimary
                  ? AppTheme.bgDeep
                  : (_hovered ? AppTheme.cyan : AppTheme.textPrimary),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String value;
  final String label;

  const _StatBadge({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
        ),
      ],
    );
  }
}

// ─────────────────────────── PROJECTS ────────────────────────────

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      color: AppTheme.bgSurface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            keyName: 'projects_header',
            child: const SectionHeader(
              eyebrow: 'Work',
              title: 'Featured Projects',
              subtitle: 'Production apps built with Flutter, shipped to real users.',
            ),
          ),
          const SizedBox(height: 48),
          isWide
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: PortfolioData.projects.length,
                  itemBuilder: (_, i) => ProjectCard(
                    project: PortfolioData.projects[i],
                    index: i,
                  ),
                )
              : Column(
                  children: PortfolioData.projects
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ProjectCard(project: e.value, index: e.key),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

// ─────────────────────────── SKILLS ────────────────────────────

class _SkillsSection extends StatelessWidget {
  final VoidCallback onVisible;
  final bool skillsVisible;

  const _SkillsSection({
    super.key,
    required this.onVisible,
    required this.skillsVisible,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return VisibilityDetector(
      key: const Key('skills_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2) onVisible();
      },
      child: Container(
        color: AppTheme.bgDeep,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 80 : 24,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              keyName: 'skills_header',
              child: const SectionHeader(
                eyebrow: 'Expertise',
                title: 'Skills & Stack',
                subtitle: 'Technologies I use to build world-class Flutter apps.',
              ),
            ),
            const SizedBox(height: 48),
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: PortfolioData.skills
                          .sublist(0, 4)
                          .asMap()
                          .entries
                          .map((e) => AnimatedSkillBar(
                                skill: e.value,
                                index: e.key,
                                animate: skillsVisible,
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    child: Column(
                      children: PortfolioData.skills
                          .sublist(4)
                          .asMap()
                          .entries
                          .map((e) => AnimatedSkillBar(
                                skill: e.value,
                                index: e.key + 4,
                                animate: skillsVisible,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: PortfolioData.skills
                    .asMap()
                    .entries
                    .map((e) => AnimatedSkillBar(
                          skill: e.value,
                          index: e.key,
                          animate: skillsVisible,
                        ))
                    .toList(),
              ),
            const SizedBox(height: 48),
            RevealOnScroll(
              keyName: 'tools_chips',
              child: _ToolsRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolsRow extends StatelessWidget {
  final _tools = const [
    'VS Code', 'Android Studio', 'Xcode', 'Figma', 'Postman',
    'GitHub Actions', 'Fastlane', 'Firebase Console', 'Dart DevTools',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TOOLS & ENVIRONMENT',
          style: TextStyle(
            fontSize: 11,
            color: AppTheme.textMuted,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _tools
              .asMap()
              .entries
              .map(
                (e) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  child: Text(
                    e.value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textMuted,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: e.key * 60),
                      duration: 400.ms,
                    )
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      delay: Duration(milliseconds: e.key * 60),
                      duration: 400.ms,
                    ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ─────────────────────────── EXPERIENCE ────────────────────────────

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      color: AppTheme.bgSurface,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            keyName: 'exp_header',
            child: const SectionHeader(
              eyebrow: 'Journey',
              title: 'Experience',
              subtitle: 'The path that shaped my Flutter expertise.',
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(
            keyName: 'exp_timeline',
            child: ExperienceTimeline(items: PortfolioData.experience),
          ),
        ],
      ),
    );
  }
}

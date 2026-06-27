import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class PortfolioNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _scrolled = false;

  static const _navItems = ['Home', 'Projects', 'Skills', 'Experience', 'Contact'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset > 60;
    if (isScrolled != _scrolled) {
      setState(() => _scrolled = isScrolled);
    }
  }

  void _scrollTo(int index) {
    if (index >= widget.sectionKeys.length) return;
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppTheme.bgDeep.withOpacity(0.92)
            : Colors.transparent,
        border: _scrolled
            ? Border(
                bottom: BorderSide(
                  color: AppTheme.borderColor.withOpacity(0.6),
                ),
              )
            : null,
        boxShadow: _scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              // Logo
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.cyan, AppTheme.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.bgDeep,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'alex.dev',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (isWide)
                Row(
                  children: _navItems.asMap().entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: _NavItem(
                        label: e.value,
                        onTap: () => _scrollTo(e.key),
                      ),
                    );
                  }).toList(),
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.textPrimary),
                  onPressed: () => _showDrawer(context),
                ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0, duration: 500.ms);
  }

  void _showDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _navItems.asMap().entries.map((e) {
            return ListTile(
              title: Text(e.value, style: const TextStyle(color: AppTheme.textPrimary)),
              onTap: () {
                Navigator.pop(ctx);
                _scrollTo(e.key);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _hovered ? AppTheme.cyan : AppTheme.textMuted,
            letterSpacing: 0.3,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

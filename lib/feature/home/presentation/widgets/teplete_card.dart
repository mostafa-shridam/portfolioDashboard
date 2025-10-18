import 'package:flutter/material.dart';

import '../../../../core/theme/style.dart';

class TemplateCard extends StatefulWidget {
  final int index;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String badge;
  final List<String> features;
  final bool isDark;
  final double screenWidth;
  final bool isSelected;
  final VoidCallback onTap;

  const TemplateCard({
    super.key,
    required this.index,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.badge,
    required this.features,
    required this.isDark,
    required this.screenWidth,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<TemplateCard> createState() => _TemplateCardState();
}

class _TemplateCardState extends State<TemplateCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withAlpha(15),
                      widget.color.withAlpha(5),
                    ],
                  )
                : null,
            color: widget.isSelected
                ? null
                : (widget.isDark ? greenSwatch.shade800 : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSelected
                  ? widget.color
                  : (_isHovered
                        ? widget.color.withAlpha(50)
                        : (widget.isDark
                              ? greenSwatch.shade600
                              : Colors.grey[300]!)),
              width: widget.isSelected ? 3 : (_isHovered ? 2 : 1),
            ),
            boxShadow: widget.isSelected || _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withAlpha(
                        widget.isSelected ? 40 : 20,
                      ),
                      blurRadius: widget.isSelected ? 16 : 8,
                      offset: Offset(0, widget.isSelected ? 6 : 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(5),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Decorative background circles
                Positioned(
                  top: -15,
                  right: -15,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withAlpha(6),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withAlpha(4),
                    ),
                  ),
                ),
                // Main content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with icon and badge
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  widget.color,
                                  widget.color.withAlpha(70),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.color.withAlpha(40),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          Spacer(),
                          // Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.badge,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Title
                      Text(
                        widget.title,
                        style: textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      // Description
                      Text(
                        widget.description,
                        style: textTheme.bodySmall?.copyWith(
                          color: widget.isDark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontSize: 3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      // Features chips
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.features.map((feature) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: widget.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: widget.color.withValues(alpha: 0.4),
                                width: 0.5,
                              ),
                            ),
                            child: Text(
                              feature,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(fontSize: 2.6),
                            ),
                          );
                        }).toList(),
                      ),
                      Spacer(),
                      // Action row
                      Row(
                        children: [
                          if (widget.isSelected) ...[
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: widget.color,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Selected',
                                style: textTheme.bodySmall?.copyWith(
                                  color: widget.color,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ] else ...[
                            Icon(
                              Icons.touch_app,
                              size: 14,
                              color: widget.color,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Select',
                                style: textTheme.bodySmall?.copyWith(
                                  color: widget.color,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          Icon(
                            _isHovered
                                ? Icons.arrow_forward
                                : Icons.chevron_right,
                            size: 16,
                            color: widget.color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

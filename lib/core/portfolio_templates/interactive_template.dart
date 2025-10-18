import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../theme/style.dart';

class InteractiveTemplate extends StatefulWidget {
  final UserModel userData;

  const InteractiveTemplate({super.key, required this.userData});

  @override
  State<InteractiveTemplate> createState() => _InteractiveTemplateState();
}

class _InteractiveTemplateState extends State<InteractiveTemplate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            dangerRed.withAlpha(30),
            primaryColor.withAlpha(30),
            accentColor.withAlpha(30),
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(48),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_controller.value * 0.1),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        widget.userData.profileImage != null &&
                            widget.userData.profileImage!.isNotEmpty
                        ? NetworkImage(widget.userData.profileImage!)
                        : null,
                    child:
                        widget.userData.profileImage == null ||
                            widget.userData.profileImage!.isEmpty
                        ? Icon(Icons.person, size: 80, color: primaryColor)
                        : null,
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Text(
              widget.userData.name ?? 'Interactive Portfolio',
              style: textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.userData.bio ?? 'Dynamic & Engaging',
              style: textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 48),

            // Animated cards
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: List.generate(
                6,
                (index) => TweenAnimationBuilder(
                  duration: Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, size: 48, color: dangerRed),
                                SizedBox(height: 12),
                                Text(
                                  'Feature ${index + 1}',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/draggable_element_model.dart';
import '../services/firebase_template_service.dart';

class DraggableElement extends StatefulWidget {
  final Widget child;
  final String elementId;
  final String elementType;
  final String userId;
  final String templateId;
  final double? initialX;
  final double? initialY;
  final Function(DraggableElementModel)? onPositionChanged;
  final bool isEditable;

  const DraggableElement({
    super.key,
    required this.child,
    required this.elementId,
    required this.elementType,
    required this.userId,
    required this.templateId,
    this.initialX,
    this.initialY,
    this.onPositionChanged,
    this.isEditable = true,
  });

  @override
  State<DraggableElement> createState() => _DraggableElementState();
}

class _DraggableElementState extends State<DraggableElement> {
  late double _x;
  late double _y;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _x = widget.initialX ?? 0.0;
    _y = widget.initialY ?? 0.0;
  }

  void _updatePosition(double newX, double newY) {
    setState(() {
      _x = newX;
      _y = newY;
    });

    // إنشاء نموذج العنصر الجديد
    final element = DraggableElementModel(
      id: widget.elementId,
      type: widget.elementType,
      x: newX,
      y: newY,
      lastModified: DateTime.now(),
    );

    // حفظ الموضع في Firebase
    FirebaseTemplateService.saveElementPosition(
      userId: widget.userId,
      templateId: widget.templateId,
      element: element,
    );

    // استدعاء callback إذا كان متوفراً
    widget.onPositionChanged?.call(element);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEditable) {
      return Positioned(left: _x, top: _y, child: widget.child);
    }

    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _isDragging = true;
          });
        },
        onPanUpdate: (details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final size = renderBox.size;
          final parentSize = MediaQuery.of(context).size;

          double newX = _x + details.delta.dx;
          double newY = _y + details.delta.dy;

          // التأكد من أن العنصر لا يخرج من حدود الشاشة
          newX = newX.clamp(0.0, parentSize.width - size.width);
          newY = newY.clamp(0.0, parentSize.height - size.height);

          setState(() {
            _x = newX;
            _y = newY;
          });
        },
        onPanEnd: (details) {
          setState(() {
            _isDragging = false;
          });
          _updatePosition(_x, _y);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: _isDragging
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              widget.child,
              if (widget.isEditable && _isDragging)
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.drag_indicator,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

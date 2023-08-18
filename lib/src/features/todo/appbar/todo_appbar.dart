import 'package:flutter/material.dart';
import 'package:langpocket/src/common_widgets/responsive_center.dart';

class TodoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TodoAppBar({super.key});

  @override
  State<TodoAppBar> createState() => _TodoAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(130);
}

class _TodoAppBarState extends State<TodoAppBar> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return ResponsiveCenter(
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 37),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38))),
        bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: CustomUnderlineTabIndicator(),
            labelPadding: const EdgeInsets.all(2),
            tabs: const [
              Tab(
                  icon: Icon(
                Icons.toc,
                size: 30,
              )),
              Tab(
                  icon: Icon(
                Icons.calendar_month,
                size: 30,
              )),
            ]),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Your Todo List',
            style: textStyle.headlineLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomUnderlineTabIndicator extends Decoration {
  @override
  CustomUnderlinePainter createBoxPainter([VoidCallback? onChanged]) =>
      CustomUnderlinePainter(this, onChanged);
}

class CustomUnderlinePainter extends BoxPainter {
  final CustomUnderlineTabIndicator decoration;

  CustomUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2; // Thickness of underline

    const double extraWidth = 45; // Extra width you want on each side
    final double startX =
        offset.dx + configuration.size!.width / 2 - extraWidth;
    final double endX = offset.dx + configuration.size!.width / 2 + extraWidth;
    final double yPosition = offset.dy + configuration.size!.height - 2;

    canvas.drawLine(Offset(startX, yPosition), Offset(endX, yPosition), paint);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_website/pixel/services/canvas_service.dart';
import 'package:flutter_website/pixel/views/functions/show_snack_bar.dart';
import 'package:provider/provider.dart';

class PixelDrawer extends StatelessWidget {
  const PixelDrawer({Key? key}) : super(key: key);

  clearAnimationPressed(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Are you sure you want to clear the animation?'),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Provider.of<CanvasService>(context, listen: false)
                  .clearAnimation();
              showSnackBar(context, 'Animation Cleared');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var canvas = context.watch<CanvasService>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Row(
              children: [
                Switch(
                  value: canvas.showPreviousFrame,
                  onChanged: (_) => canvas.toggleShowPreviousFrame(),
                ),
                Text('Show Previous Frame'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Switch(
                  value: canvas.grid,
                  onChanged: (_) => canvas.toggleGrid(),
                ),
                Text('Toggle Grid'),
              ],
            ),
          ),
          ListTile(
            title: Text('Clear Animation'),
            leading: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red)),
              onPressed: () => clearAnimationPressed(context),
              child: Icon(Icons.delete_forever),
            ),
          )
        ],
      ),
    );
  }
}

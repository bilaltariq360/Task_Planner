import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddSubTask extends StatefulWidget {
  static String routeName = '/add-sub-task';
  const AddSubTask({super.key});

  @override
  State<AddSubTask> createState() => _AddSubTaskState();
}

class _AddSubTaskState extends State<AddSubTask> {
  List listTile = [
    'Buy groceries',
    'Call a friend',
    'Read a book',
    'Go for a walk',
    'Write a blog post',
    'Clean the house',
    'Plan a vacation',
    'Learn a new recipe',
    'Organize your workspace',
    'Take a yoga class',
    'Update your resume',
    'Start a new hobby',
    'Watch a movie',
    'Do a puzzle',
    'Research a new topic',
    'Volunteer at a local charity',
    'Take a nap',
    'Explore a new neighborhood',
    'Practice a musical instrument',
    'Try a new restaurant',
  ];

  Future<void> showAlertBox(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Warning'),
              const SizedBox(width: 10),
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.red[500],
              )
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this permanently?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        children: [
          for (final tile in listTile)
            Dismissible(
              key: ValueKey(tile),
              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.endToStart) {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            const Text('Warning'),
                            const SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.exclamationmark_triangle_fill,
                              color: Colors.red[500],
                            )
                          ],
                        ),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'Are you sure you want to delete this permanently?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              background: Container(
                color: Colors.green[500],
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.check_mark,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Mark as done',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red[500],
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              child: ListTile(
                key: ValueKey(tile),
                leading:
                    CircleAvatar(radius: 5, backgroundColor: Colors.blue[700]),
                title: Text(
                  tile,
                  style: const TextStyle(
                      fontSize: 15, decoration: TextDecoration.lineThrough),
                ),
                minVerticalPadding: 20,
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) newIndex--;
          final temp = listTile.removeAt(oldIndex);
          setState(() {
            listTile.insert(newIndex, temp);
          });
        },
      ),
    );
  }
}

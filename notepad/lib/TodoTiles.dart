import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatefulWidget {
  final TaskName ;
  final bool Taskcomplete;
  Function(bool?)? onChanged;//
  Function(BuildContext)? deleteFunction;


  TodoTile({
    super.key,
    required this.TaskName, //Ne fonctionnera pas s'il manque cette valeur
    required this.Taskcomplete, //Ne fonctionnera pas s'il manque cette valeur
    required this.onChanged, //Ne fonctionnera pas s'il manque cette valeur
    required this.deleteFunction,
  });

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ]
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row( // création d'une ligne
            children: [ // Children peut contenir l'élément que l'on veut
              Checkbox(value: widget.Taskcomplete, onChanged: widget.onChanged),
              Text(
                widget.TaskName,
                style: TextStyle( // si la t
                  decoration: widget.Taskcomplete
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:notepad/TodoTiles.dart';
import 'package:notepad/database.dart';
import 'package:notepad/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ref hive
  late Box _mybox;

  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    Hive.openBox("mybox").then((box) {
      _mybox = box;
      if (_mybox.get("TODOLIST") == null) {
        db.createInitialData();
      } else {
        db.loadData();
      }
      setState(() {}); // Trigger a rebuild after initialization
    });
    super.initState();
  }




  //text controller
  final _controller = TextEditingController();

  List TodoList =[

    ["faire une appli", false],
    ["faire des courses", false],
    ["faire du sport",false],

  ];

  void changedBox(bool? value, int index){

    setState(() { //on actualise la vue des états du checkbox
      db.TodoList[index][1]= !db.TodoList[index][1]; // La liste de tuiles la deuxieme colonne selon l'indice change d'état
    });
  }

  void SaveNewTask(){
    setState(() {
      db.TodoList.add([_controller.text, false]);
      _controller.clear(); // permet d'effacer le champ de text présent dans nouvelle tâche
    });
    Navigator.of(context).pop(); //ferme le dialogbox
    db.updateDataBase();
  }

  void CreateNewTask() { //créer une nouvelle tâche
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(
            controller: _controller,
            onSave: SaveNewTask,
            onCancel: () => Navigator.of(context).pop(),

          );
        }

    );
  }


  void DeleteTask(int index){
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold( // initialisation de l'écran
    backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 20,
        backgroundColor: Colors.yellow,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: CreateNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder( // on veut une liste de vue qui peut contenir beaucoup d'élément donc ListView.Builder est le plus adapter.
        //ses éléments de vue pourront être parcourru avec le scroll
        // On a déjà notre DataSource, c'est à dire la où je stocke les informations de chaque tuile créée (TodoList)
        itemCount: db.TodoList.length, // permet à itemBuilder de savoir Combien de fois on fait appel à lui
        itemBuilder:(context,index){ // est une fonction qui quand on y fait appel créé un widget
          // il a besoin de deux argument, context et index qui servent de valeur par défaut
          return TodoTile(
            //Je lui demande de me retourner le nombre de tuiles correspondant au nombre d'élément de notre datasource
              TaskName: db.TodoList[index][0], // selon l'indice dans la liste la première colonne (à faire)
              Taskcomplete: db.TodoList[index][1],// selon l'indice dans la liste la deuxième colonne (true/false)
              onChanged: (value)  => changedBox(value, index), //On veut changer le booleen contenu dans la deuxième colonne
              //Le onChanged est un argument de TodoTile pour le changement d'état de la Checkbox
              //"(value)" c'est la valeur par défaut que l'on a au départ, la valeur(true/false) de l'élément de la liste TodoList
              //On affecte à changedBox "index" pour savoir où il en est et value
              deleteFunction: (context)=> DeleteTask(index),
          );
        },

      ),
    );
  }

}
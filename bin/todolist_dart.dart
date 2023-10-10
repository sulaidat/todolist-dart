import 'dart:io';

import 'package:todolist_dart/todolist_dart.dart' as todolist_dart;

class Note {
  String msg;
  bool done;

  Note(this.msg, this.done);

  void show() {
    var done = " ";
    if (this.done) done = "X";
    print("[$done] $msg");
  }
}

class NoteList {
  late List<Note> list;

  NoteList() {
    list = <Note>[];
  }
  NoteList.fromList(this.list);

  void add() {
    stdout.write("Todo: ");
    String msg = stdin.readLineSync()!;
    stdout.write("[C]heck/[U]ncheck(default)? ");
    String buf = stdin.readLineSync()!;
    if (buf == "C") {
      list.add(Note(msg, true));
    } else {
      list.add(Note(msg, false));
    }
  }

  void showAll() {
    if (list.length == 0) {
      print("Empty list");
      return;
    }
    print("There are ${list.length} in total:");
    for (int i = 0; i < list.length; i++) {
      stdout.write("$i. ");
      list[i].show();
    }
  }

  void edit() {
    if (list.length == 0) {
      print("Empty list");
      return;
    }
    stdout.write("Index: ");
    int idx = readInt();
    stdout.write("New message: ");
    String buf = stdin.readLineSync()!;
    list[idx].msg = buf;
    stdout.write("[C]heck/[U]ncheck (default)? ");
    buf = stdin.readLineSync()!;
    if (buf == "C") {
      list[idx].done = true;
    } else {
      list[idx].done = false;
    }
  }

  void delete() {
    if (list.isEmpty) {
      print("Empty list");
      return;
    }
    stdout.write("Index: ");
    int idx = readInt();
    list.removeAt(idx);
  }

  void filter(bool done) {
    for (var note in list) {
      if (note.done == done) {
        note.show();
      }
    }
  }
}

void fatal(String msg) {
  print(msg);
  exit(-1);
}

int readInt() {
  var choice = int.tryParse(stdin.readLineSync()!);
  if (choice != null) {
    return choice;
  } else {
    fatal("Invalid number");
  }
  return -1;
}

void menu() {
  print("1. Add\n"
        "2. Show all\n"
        "3. Edit\n"
        "4. Delete\n"
        "5. Filter\n"
        "6. Exit\n");
  stdout.write("> ");
}

void app() {
  print("This is a simple todo list");
  NoteList list = NoteList();

  while (true) {
    menu();
    int choice = readInt();
    switch (choice) {
      case 1:
        list.add();
        break;
      case 2:
        list.showAll();
        break;
      case 3:
        list.edit();
        break;
      case 4:
        list.delete();
        break;
      case 5:
        stdout.write("[D]one/[N]ot done?");
        String buf = stdin.readLineSync()!;
        if (buf == 'D') {
          list.filter(true);
        } else if (buf == "N") {
          list.filter(false);
        }
        break;
      default:
        exit(0);
    }
  }
}

void main(List<String> arguments) {
  app();
}

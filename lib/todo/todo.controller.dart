import 'package:get/get.dart';
import 'package:lists/auth/auth.controller.dart';
import 'package:lists/todo/todo.model.dart';
import 'package:lists/todo/todo.service.dart';


class TodoController extends GetxController {
  static TodoController to = Get.find();
  RxList<Todo> todos = List<Todo>.empty().obs; // Observable of the user todo list
  RxBool isLoadingTodos = false.obs;
  RxBool isAddingTodo = false.obs;
  RxBool isLoadingDetails = false.obs;
  Todo activeTodo;
  TodoService _todoService;
  TodoController() {
    _todoService = TodoService();
  }

  @override
  onInit() {
    //here we tell todos to stream from the load todos method.
    todos.bindStream(loadTodos());
  }

  Stream<Iterable<Todo>> loadTodos() {
    AuthController authController = AuthController.to;
    return _todoService.findAll(authController.user.value.uid);
  }

  Future<Todo> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeTodo = await _todoService.findOne(id);
      print(activeTodo);
      isLoadingDetails.value = false;
      return activeTodo;
    } catch (e) {
      return null;
    }
  }

  addTodo(String title) async {
    try {
      AuthController authController = AuthController.to;
      isAddingTodo.value = true;
      var todo =
          await _todoService.addOne(authController.user.value.uid, title);
      todos.add(todo);
      Get.snackbar("Success", todo.title, snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  updateTodo(Todo todo) async {
    try {
      isAddingTodo.value = true;
      await _todoService.updateOne(todo);
      int index = todos.value.indexWhere((element) => element.id == todo.id);

      todos[index] = todo;
      print(todos);
      Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }

  deleteTodo(String id) async {
    try {
      await _todoService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }
}
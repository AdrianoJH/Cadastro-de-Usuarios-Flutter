import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user,
              );
            },
            icon: const Icon(Icons.edit),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text('Excluir Usuário'),
                          content: const Text('Tem certeza???'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<Users>(context, listen: false)
                                    .remove(user);
                                     Navigator.of(context).pop();
                              },
                              child: const Text('Sim'),
                            ),
                          ]));
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ]),
      ),
    );
  }
}

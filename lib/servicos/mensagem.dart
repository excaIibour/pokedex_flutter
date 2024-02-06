import 'package:flutter/material.dart';

//função para exibição de mensagem em caso de erro, recebendo o contexto de onde for aplicada
class Mensagem {
  void exibirMensagem(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }
}
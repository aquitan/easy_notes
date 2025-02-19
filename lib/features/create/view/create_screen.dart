import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

@RoutePage()
class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заметку'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(spacing: 16.0, children: [
          TextField(
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
            controller: titleController,
            decoration: InputDecoration(label: const Text('Введи заголовок')),
          ),
          Expanded(
              child: QuillEditor.basic(
            controller: _controller,
            config: const QuillEditorConfig(placeholder: 'Введи текст'),
          )),
          QuillSimpleToolbar(

            controller: _controller,
            config: const QuillSimpleToolbarConfig(
              showCodeBlock: false,
              showQuote: false,
              showLineHeightButton: false,
              showInlineCode: false,
              showRedo: false,
              showUndo: false,
              showFontFamily: false,
              showSubscript: false,
              showSuperscript: false,
              showSearchButton: false,
              showFontSize: false,
              showHeaderStyle: false,
              showBackgroundColorButton: false,
              showIndent: false,
              showItalicButton: false,
            ),
          ),
        ]),
      ),
    );
  }
}
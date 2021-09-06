import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:vivasayi/constants/navigator_constants.dart';
import 'package:vivasayi/models/data_model/data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/universal_ui/universal_ui.dart';
import 'package:vivasayi/util/navigation.dart';

class ReadStoryScreen extends StatefulWidget {
  @override
  _ReadStoryScreenState createState() => _ReadStoryScreenState();
}

class _ReadStoryScreenState extends State<ReadStoryScreen> {
  final FocusNode _focusNode = FocusNode();
  QuillController? _controller;
  bool _loading = false;
  late ReadStoryDataModel readStoryDataModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readStoryDataModel =
        ModalRoute.of(context)!.settings.arguments as ReadStoryDataModel;

    if (_controller == null && !_loading) {
      _loading = true;
      _loadContent(readStoryDataModel);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(readStoryDataModel.storyScreenId.title),
        backgroundColor: Theme.AppColors.toolBarBackgroundColor,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.AppColors.iconColor,
              ),
              onPressed: () {
                onTapEdit(readStoryDataModel);
              },
            ),
          )
        ],
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) =>
      _loading ? LoadingIndicator() : _buildContent(context, _controller);

  Widget _buildContent(BuildContext context, QuillController? controller) {
    var quillEditor = QuillEditor(
      controller: controller!,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: true,
      expands: false,
      padding: EdgeInsets.zero,
    );
    if (kIsWeb) {
      quillEditor = QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: _focusNode,
          autoFocus: false,
          readOnly: true,
          expands: false,
          padding: EdgeInsets.zero,
          embedBuilder: defaultEmbedBuilderWeb);
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: quillEditor,
      ),
    );
  }

  Future<void> _loadContent(ReadStoryDataModel readStoryDataModel) async {
    try {
      final doc =
          Document.fromJson(jsonDecode(readStoryDataModel.story.content));
      setState(() {
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
        _loading = false;
      });
    } catch (error) {}
  }

  onTapEdit(ReadStoryDataModel readStoryDataModel) {
    readStoryDataModel.isEdit = true;
    Navigation()
        .popAndPushNamed(context, ROUTE_CREATE_STORY, data: readStoryDataModel);
  }
}

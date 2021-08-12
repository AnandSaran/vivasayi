import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:tuple/tuple.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/universal_ui/universal_ui.dart';
import 'package:vivasayi/util/navigation.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({Key? key, required this.collectionName})
      : super(key: key);
  final String collectionName;

  @override
  _CreateStoryState createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStoryScreen> {
  late PostBloc _bloc;

  /// Allows to control the editor and the document.
  late QuillController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  late FocusNode _focusNode;

  /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
*/
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PostBloc>(context);
    _bloc.setStoryCollectionName(widget.collectionName);
    _focusNode = FocusNode();
    try {
      _controller = _bloc.loadEmptyDocument();
    } catch (error) {
      _bloc.loadDocument().then((controller) {
        setState(() {
          _controller = controller;
          _bloc.showProgressBar(false);
        });
      });
    }
    _postUploadCompleteListener();
    _showSelectStoryGenreScreenListener();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return StreamBuilder(
        stream: _bloc.showProgress,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.data == false) {
            return RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event.data.isControlPressed && event.character == 'b') {
                  if (_controller
                      .getSelectionStyle()
                      .attributes
                      .keys
                      .contains('bold')) {
                    _controller
                        .formatSelection(Attribute.clone(Attribute.bold, null));
                  } else {
                    _controller.formatSelection(Attribute.bold);
                  }
                }
              },
              child: _buildWelcomeEditor(context),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(CREATE_STORY),
        backgroundColor: Theme.AppColors.toolBarBackgroundColor,
        actions: <Widget>[
          /* Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.save,
                color: Theme.Colors.iconColor,
              ),
              onPressed: () => _bloc.saveDocument(context, _controller),
            ),
          ),*/
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.cloud_upload,
                color: Theme.AppColors.iconColor,
              ),
              onPressed: () => _bloc.submit(
                  context,
                  _bloc.getContent(_controller),
                  _bloc.getPlainText(_controller)),
            ),
          )
        ],
      ),
      body: body(),
    );
  }

  void _postUploadCompleteListener() {
    _bloc.isPostUploaded.listen((event) {
      if (event) {
        Navigation().pop(context);
      }
    });
  }

  void _showSelectStoryGenreScreenListener() {
    _bloc.showSelectStoryGenrePage.listen((event) {
      if (event) {
        showSelectGenrePage();
      }
    });
  }

  void showSelectGenrePage() async {
    StoryGenre storyGenre = await Navigation()
        .pushPageResult(context, ROUTE_SELECT_GENRE) as StoryGenre;
    print("Result back : " + storyGenre.toString());
    _bloc.addUserPost(storyGenre.genreName);
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    var quillEditor = QuillEditor(
        controller: _controller!,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Add content',
        expands: false,
        padding: EdgeInsets.zero,
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              null),
          sizeSmall: const TextStyle(fontSize: 9),
        ));
    if (kIsWeb) {
      quillEditor = QuillEditor(
          controller: _controller!,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: _focusNode,
          autoFocus: false,
          readOnly: false,
          placeholder: 'Add content',
          expands: false,
          padding: EdgeInsets.zero,
          customStyles: DefaultStyles(
            h1: DefaultTextBlockStyle(
                const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  height: 1.15,
                  fontWeight: FontWeight.w300,
                ),
                const Tuple2(16, 0),
                const Tuple2(0, 0),
                null),
            sizeSmall: const TextStyle(fontSize: 9),
          ),
          embedBuilder: defaultEmbedBuilderWeb);
    }
    var toolbar = QuillToolbar.basic(
        controller: _controller,
        onImagePickCallback: _onImagePickCallback,
        onVideoPickCallback: _onVideoPickCallback);
    if (kIsWeb) {
      toolbar = QuillToolbar.basic(
          controller: _controller!,
          onImagePickCallback: _onImagePickCallback,
          webImagePickImpl: _webImagePickImpl);
    }
    final isDesktop = !kIsWeb && !Platform.isAndroid && !Platform.isIOS;
    if (isDesktop) {
      toolbar = QuillToolbar.basic(
          controller: _controller!,
          onImagePickCallback: _onImagePickCallback,
          filePickImpl: openFileSystemPickerForDesktop);
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: quillEditor,
            ),
          ),
          kIsWeb
              ? Expanded(
                  child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: toolbar,
                ))
              : Container(child: toolbar)
        ],
      ),
    );
  }

  Future<String?> openFileSystemPickerForDesktop(BuildContext context) async {
    return await FilesystemPicker.open(
      context: context,
      rootDirectory: await getApplicationDocumentsDirectory(),
      fsType: FilesystemType.file,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    /* // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${Path.basename(file.path)}');
    return copiedFile.path.toString();*/

    return _bloc.uploadFile(file);
  }

  Future<String?> _webImagePickImpl(
      OnImagePickCallback onImagePickCallback) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }

    // Take first, because we don't allow picking multiple files.
    final fileName = result.files.first.name;
    final file = File(fileName);

    return onImagePickCallback(file);
  }

  // Renders the video picked by imagePicker from local file storage
  // You can also upload the picked video to any server (eg : AWS s3
  // or Firebase) and then return the uploaded video URL.
  Future<String> _onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${Path.basename(file.path)}');
    return copiedFile.path.toString();
  }
}

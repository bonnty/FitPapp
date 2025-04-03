import 'dart:developer';

import 'package:fit_papp/resources/playlist.dart';
import 'package:flutter/material.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          GestureDetector(
              child: AppBar(
                title: Text('click me to open a magic world'),
              ),
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (context) => PlaylistDialog(),
                );
              },
          ),
        ],
      ),
    );
  }
}

class PlaylistDialog extends StatefulWidget {
  @override
  State<PlaylistDialog> createState() => _PlaylistDialogState();
}

class _PlaylistDialogState extends State<PlaylistDialog> {
  Playlist? _selectedPlaylist = playlists[0];

  @override
  Widget build(BuildContext context) {
    return Dialog(      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Title(
            color: Colors.white,
            child: 
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.playlist_play_outlined),
                    Text(
                      "Playlists",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                  ],
                ),
              ),
          ),
          Divider(height: 0),
          Flexible(
            child: ReorderableListView.builder(
              buildDefaultDragHandles: false,
              padding: EdgeInsets.zero,
              onReorder: (oldIndex, newIndex){
                    setState(() {
                    if (oldIndex < newIndex) {
                      // When moving down, the destination index needs to be adjusted
                      newIndex -= 1;
                    }
                    final item = playlists.removeAt(oldIndex);
                    playlists.insert(newIndex, item);
                  });
              },
              shrinkWrap: true,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return ListTile(
                  key: ValueKey(playlist),
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Row(
                    children: [
                      ReorderableDragStartListener(
                        index: index,
                        child: Icon(Icons.drag_handle_outlined),
                      ),
                      Expanded(
                        child: RadioListTile<Playlist>(
                          title: Text(playlist.title),
                          contentPadding: EdgeInsets.only(left: 10),
                          value: playlist,
                          groupValue: _selectedPlaylist,
                          onChanged: (Playlist? value){
                            setState(() {
                              _selectedPlaylist = value;
                            });
                          }, 
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          log('rename $playlist');
                          _showRenameDialog(playlist);
                        },
                        icon: Icon(Icons.drive_file_rename_outline, size: 20),
                      ),
                      IconButton(
                        onPressed: () => log('delete $playlist'),
                        icon: Icon(Icons.delete_outline_outlined, size: 20),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(Playlist playlist) {
    final TextEditingController textController = TextEditingController(text: playlist.title);
    showDialog(
      context: context,
      builder: (BuildContext context){ 
        return AlertDialog(
          title: Text('Rename Item'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Enter new name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  playlist.title = textController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Rename'),
            ),
          ],
        );
      }
    );
  }
   
}

List<Playlist> playlists = [
  Playlist()
  ..title="Upper body"
  ..position=0
  ..item=["exo 1", "exo 2"],
  Playlist()
  ..title="Lower body"
  ..position=1
  ..item=["exo 3", "exo 4"],
  Playlist()
  ..title="All body"
  ..position=2
  ..item=["exo 1", "exo 2", "exo 3", "exo 4"],
  ];


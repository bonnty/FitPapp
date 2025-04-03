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
                    Text("Playlists"),
                  ],
                ),
              ),
          ),
          Flexible(
            child: ReorderableListView.builder(
              padding: EdgeInsets.only(right: 20),
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
                  contentPadding: EdgeInsets.only(right: 30),
                  title: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Playlist>(
                          title: Text(playlist.title),
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
                        onPressed: () => log('rename $playlist'),
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


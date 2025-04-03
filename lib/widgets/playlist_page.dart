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
  SingingCharacter? _character = SingingCharacter.lafayette;

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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: SingingCharacter.values.length,
              itemBuilder: (context, index) {
                final cingchar = SingingCharacter.values[index];
                return Row(
                  children: [
                    Expanded(
                      child: RadioListTile<SingingCharacter>(
                        title: Text(cingchar.name),
                        value: cingchar,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value){
                          setState(() {
                            _character = value;
                          });
                        }, 
                      )
                    ),
                    IconButton(
                      onPressed: () => log('rename $cingchar'),
                      icon: Icon(Icons.drive_file_rename_outline),
                    ),
                    IconButton(
                      onPressed: () => log('delete $cingchar'),
                      icon: Icon(Icons.delete_outline_outlined),
                    ),
                  ],
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

enum SingingCharacter { lafayette, jefferson, garfield, 
lafayettea, jeffersona, garfielda, 
lafayetteb, jeffersonb, garfieldb,
lafayettec, jeffersonc, garfieldc,
lafayetted, jeffersond, garfieldd }

library guillotine;

import 'package:irc/irc.dart';

BotConfig config = new BotConfig(
    nickname    : 'Guillotine',
    username    : 'Guillotine',
    host        : '192.168.2.24',
    port        : 6667
);

List channels =
[
  '#soc-bots',
  '#sociomantic'
];

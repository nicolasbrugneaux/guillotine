library guillotine;

import 'dart:io';

import 'package:irc/irc.dart';

import 'config.dart';
import 'okay.dart';

CommandBot Guillotine = new CommandBot(
    config,
    prefix  : '`'
);

bool isIdentified   = false;
bool bullshit       = false;

reply ( CommandEvent event, String message )
{
    String trueMsg = message.replaceAll(
        new RegExp( r'nico', caseSensitive : true ), 'The Creator' );

    return event.reply( bullshit ? okay( trueMsg ) : trueMsg );
}

Map commands =
{
    'help' : ( CommandEvent event )
    {
        reply( event,
            "> ${Color.BLUE}Commands${Color.RESET}: ${Guillotine.commandNames().join(', ')}" );
    },
    'dart' : ( CommandEvent event )
    {
        reply( event, '> Dart VM: ${Platform.version}' );
    },
    'whoami' : ( CommandEvent event )
    {
        reply( event, '> You are ${event.from}! <3' );
    },
    'whois' : ( CommandEvent event )
    {
        reply( event, '> He/She is ${event.argument(0)}!' );
    },
    'ping' : ( CommandEvent event )
    {
        reply( event, '> pong' );
    },
    'pong' : ( CommandEvent event )
    {
        reply( event, '> I don\'t have time for your stupid games.' );
    },
    'balance' : ( CommandEvent event )
    {
        if ( !isIdentified )
        {
            Guillotine.client.message( 'NickServ', 'identify guillotine_rules' );
            isIdentified = true;
        }
        Guillotine.client.message( '_val_00B5', 'balance' );
    },
    'BS' : ( CommandEvent event )
    {
        bullshit = !bullshit;
        String state = bullshit ? 'enabled' : 'disabled';
        reply( event, '> Bullshit mode is now ' + state + '.' );
    },
    'BS?' : ( CommandEvent event )
    {
        String state = bullshit ? 'enabled' : 'disabled';
        reply( event, '> Bullshit mode is currently ' + state + '.' );
    },
    'guillotine' : ( CommandEvent event )
    {
        reply( event, 'I\'m not ready yet.' );
    }
};

void setup()
{
    Guillotine.register( ( MOTDEvent event )
    {
        print( event.message );
    } );

    Guillotine.register( ( ReadyEvent event )
    {
        channels.forEach( (channel ) => event.join( channel ) );
    } );

    commands.forEach( ( command, cb )
    {
        Guillotine.command( command, cb );
    } );


    Guillotine.register( ( BotJoinEvent event )
    {
        print( 'Joined ${event.channel.name}' );
    } );

    Guillotine.register( ( BotPartEvent event )
    {
        print( 'Left ${event.channel.name}' );
    } );

    Guillotine.register( ( MessageEvent event )
    {
        switch ( event.from )
        {
            case '_val_00B5':
                if ( event.channel == null )
                {
                    Guillotine.client.message( '#soc-bots',
                        '> ' + event.message.replaceAll( new RegExp( r'you',
                            caseSensitive : true ), 'I' ) );
                }
                break;
            default:
                print( '<${event.target}><${event.from}> ${event.message}' );
                break;
        }
    } );
}

void main()
{
    setup();
    Guillotine.connect();
}





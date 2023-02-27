package hxdiscord;

import hxdiscord.gateway.Gateway;
import hxdiscord.gateway.OpCode;
import hxdiscord.endpoints.Endpoints;
import hxdiscord.net.WebSocketConnection;
import hxdiscord.types.*;
import hxdiscord.types.structTypes.*;
import hxdiscord.utils.Https;
import haxe.Timer;

/**
    This is the so-called "heart" of the application you're building. This will be used to handle events from Discord.
**/

class RevoltClient
{
    public static var token:String = "";
    public static var debug:Bool;
    var ws:WebSocketConnection;
    var heartbeatTimer:Timer;

    public var email:Dynamic;
    public var discriminator:String = "";
    @:dox(hide)
    public var bot:Bool = false;

    /**
        Constructor. This will start a new haxvolt instance.
        @param _token Your session token. Works for bots only.
        @param _debug Debug mode. This will print every single websocket incomming message from the Discord Gateway.
    **/

    public function new(_token:String, ?_debug:Bool)
    {
        token = _token;

        connect();
    }

    @:dox(hide)
    public function tick() {}

    @:dox(hide)
    function connect()
        {
            try {
                if (debug)
                    trace("Connecting");

                var url = Gateway.GATEWAY_URL;

                ws = new WebSocketConnection(url);
                ws.onMessage = this.wsm;
                ws.onClose = (m:Int) != null;
                {
                    heartbeatTimer.stop();
                }

                if (m == 4006 || m == 1000 || m == 1001) // Session has expired.
                    {
                        session_id = "";
                        session = "";
                        session_type = "";
                        canResume = false;

                        Gateway.GATEWAY_URL = "wss://ws.revolt.chat?version="+Gateway.API_VERSION+"&encoding=json";
                    }
            }
        }
}


package haxvolt;

import haxvolt.gateway.Gateway;
import haxvolt.gateway.OpCode;
import haxvolt.endpoints.Endpoints;
import haxvolt.net.WebSocketConnection;
import haxvolt.types.*;
import haxvolt.types.structTypes.*;
import haxvolt.utils.Https;
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
    public var status:String = "online";
    private var canResume:Bool = false;
    var receivedHelloOC:Bool = false;
    private var ignore:Bool = false;
    private var sequence:String = "";
    private var session:String = "";
    private var session_type:String = "";
    private var session_id:String = "";
    private var resume_gateway_url:String = "";   

    public var readySent:Bool = false;
    @:dox(hide)
    public var verified:Bool = false;
    public var username:String = "";
    @:dox(hide)
    public var mfa_enabled = false;
    public static var accountId:String = "";
    @:dox(hide)
    public var email:Dynamic;
    @:dox(hide)
    public var password:Dynamic;
    @:dox(hide)
    public var bot:Bool = false;
    @:dox(hide)
    public var avatar:Dynamic;

    public var presence:String = "";
    public var presenceType:Int = 99;

    /**
        Constructor. This will start a new haxvolt instance.
        @param _token Your session token. Works for bots only as of now.
        @param _debug Debug mode. This will print every single websocket incomming message from the Revolt Gateway.
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

                if (m == 4006 || m == 1000 || m == 1001) // Session has expired, otherwise connect to the Revolt Gateway.
                    {
                        session_id = "";
                        session = "";
                        session_type = "";
                        canResume = false;

                        Gateway.GATEWAY_URL = "wss://ws.revolt.chat?version=" + Gateway.API_VERSION + "&encoding=json";
                    }

                    if (debug) 
                    {
                        trace("[INFO] The WebSocket has closed with code: " + m + ". Re-opening...");
                    }
                    connect();
                };
                ws.onError = (e) -> 
                {
                    throw("[ERROR] WebSocket threw an error.");
                }
        } catch (err)
        {
            throw(err);
        }
    }


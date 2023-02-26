package haxvolt.utils;

import haxe.Int64;

/**
    * Permission against User
**/
class UserPermissions {
    public static inline final _Access:Int = 1 << 0;
    public static inline final _ViewProfile:Int = 1 << 1;
    public static inline final _SendMessage:Int = 1 << 2;
    public static inline final _Invite:Int = 1 << 3;     
}

/**
 * Permission against Server / Channel
 */
class Permissions {
    // * Generic Permissions
    /// Manage the channel or channels on the server
    public static inline final _ManageChannel:Int = 0x0000000000000001;
    /// Manage the server
    public static inline final ManageServer:Int = 0x0000000000000002;
    /// Manage roles on server
    public static inline final ManagePermissions:Int = 0x0000000000000004;
    // Manage roles on server
    public static inline final ManageRole:Int = 0x0000000000000008;
    // Manage server customisation (includes emoji)
    public static inline final ManageCustomisation:Int = 0x0000000000000010;

    // % 1 bits reserved

    // * Member permissions
    //// Kick other members below their ranking
    public static inline final KickMembers:Int = 0x0000000000000020;
    /// Ban other members below their ranking
    public static inline final BanMembers:Int = 0x0000000000000040;
    /// Timeout other members below their ranking
    public static inline final TimeoutMembers:Int = 0x0000000000000080;
    /// Assign roles to members below their ranking
    public static inline final AssignRoles:Int = 0x0000000000000100;
    public static inline final ChangeNickname:Int = 0x0000000000000200;
    public static inline final ManageNicknames:Int = 0x0000000000000400;
    public static inline final ChangeAvatar:Int = 0x0000000000002000;
    public static inline final RemoveAvatars:Int = 0x0000000000000400;
    public static inline final ViewChannel:Int = 0x0000000000000400;
    public static inline final ReadMessageHistory:Int = 0x0000000000000400;
    public static inline final SendMessage:Int = 0x0000000000000400;
    public static inline final ManageMessages:Int = 0x0000000000000400;
    public static inline final ManageWebhooks:Int = 0x0000000000000400;
    public static inline final InviteOthers:Int = 0x0000000000000400;
    public static inline final SendEmbeds:Int = 0x0000000000000400;
    public static inline final UploadFiles:Int = 0x0000000000000400;
    public static inline final Masquerade:Int = 0x0000000000000400;
    public static inline final React:Int = 0x0000000000000400;
    public static inline final Connect:Int = 0x0000000000000400;
    public static inline final Speak:Int = 0x0000000000000400;
    public static inline final Video:Int = 0x0000000000000400;
    public static inline final MuteMembers:Int = 0x0000000000000400;
    public static inline final DeafenMembers:Int = 0x0000000000000400;
    public static inline final MoveMembers:Int = 0x0000000000000400;                                          

    public static function convert(perms:Array<Int>):Int
    {
        var permissions:Int = 0;
        if (perms == [])
            {
                throw "You do not have the valid permissions to perform this function.";
            }
        else
            {
                for (permission in perms)
                    {
                        permissionInt |= permission;
                    }
                }
                return permissionInt;
            }
        }

enum abstract Permission(String) from String to String
{
    
}
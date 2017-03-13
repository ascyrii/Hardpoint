/* 	
*	Hardpoint.inc
*   Made by Sidezz of Realization Entertainment
*   March 10th, 2017
*/
#if defined _hardpoint_include
#endinput
#endif
#define _hardpoint_include

public SharedPlugin __pl_hardpoint = 
{
	name = "hardpoint",
	file = "hardpoint.smx",
#if defined REQUIRE_PLUGIN
	required = 1,
#else
	required = 0,
#endif
};
 
#if !defined REQUIRE_PLUGIN
public void __pl_hardpoint_SetNTVOptional()
{
	MarkNativeAsOptional("Hardpoint_GetDatabase");
}
#endif

public Handle fwd_OnDatabaseConnected = INVALID_HANDLE;

/**
 * Called when the core plugin establishes a connection to the Database.
 *
 * @param database		A handle to the database connection. This is the handle passed from the main plugin.
 * @noreturn
 */
forward void OnDatabaseConnected(Handle database);

/**
* Gets a clone of the current database handle used by the core plugin.
* 
* @return				INVALID_HANDLE if the MySQL Database has not yet connected.
*						or a cloned handle to the MySQL Database.
*/
native Handle Hardpoint_GetDatabase();

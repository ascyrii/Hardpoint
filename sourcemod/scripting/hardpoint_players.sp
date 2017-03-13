/* 	
*	Hardpoint_players.sp
*   Made by Sidezz of Realization Entertainment
*   March 10th, 2017
*
*   TODO: Make the fucking plugin.
*
*/

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <hardpoint>

//Player Stuff:
int g_Frags[MAXPLAYERS + 1] = {0, ...};
int g_Deaths[MAXPLAYERS + 1] = {0, ...};
int g_ObjectiveTime[MAXPLAYERS + 1] = {0, ...};
int g_Defends[MAXPLAYERS + 1] = {0, ...};
int g_Offends[MAXPLAYERS + 1] = {0, ...};

//Database Stuff:
Database g_Database;

public Plugin myinfo = 
{
	name = "Hardpoint - Player Stats", 
	author = "Sidezz", 
	description = "An additional module for tracking player individual stats in the Hardpoint Gamemode", 
	version = "1.0",
	url = "www.coldcommunity.com"
};

public void OnPluginStart()
{
	HookEvent("player_death", event_Death, EventHookMode_Post);
}

public void event_Death(Event event, const char[] name, bool noBroadcast)
{
	int victim = GetClientOfUserId(event.GetInt("userid"));
	int attacker = GetClientOfUserId(event.GetInt("attacker"));

	if(victim != attacker)
	{	
		g_Frags[attacker]++;
		g_Deaths[victim]++;
	}
	else if(victim == attacker)
	{
		g_Deaths[victim]++;
	}
	
	return;
}

public void OnAllPluginsLoaded()
{
	Handle db = Hardpoint_GetDatabase();
	if(db != INVALID_HANDLE)
	{
		OnDatabaseConnected(db);
		delete db;
	}
}

public void OnDatabaseConnected(Handle db)
{
	g_Database = view_as<Database>(CloneHandle(db));
}
#include <autoexecconfig>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

ConVar i_airaccel;
ConVar i_accel;
ConVar i_maxvel;

ArrayList g_MapListWhiteList;
int g_mapFileSerial = -1;

public Plugin myinfo =
{
	name        = "ez_config",
	author      = "shipy",
	description = "enforce cvars , on maps with hardcoded settings",
	version     = "1.0.0",
	url         = "https://github.com/shipyy/ez_config"
};

public void OnPluginStart()
{

	int arraySize = ByteCountToCells(PLATFORM_MAX_PATH);
	g_MapListWhiteList = new ArrayList(arraySize);

	//READ FROM FILE "/csgo/maxvel_maps.txt"
	if (ReadMapList(g_MapListWhiteList, g_mapFileSerial, "maxvel_maps", MAPLIST_FLAG_CLEARARRAY|MAPLIST_FLAG_MAPSFOLDER) != INVALID_HANDLE)
	{
		if (g_mapFileSerial == -1)
		{
			SetFailState("Unable to create a valid map list.");
		}
	}

	FindConVar("sv_airaccelerate").AddChangeHook(airacceleratesetting);
	FindConVar("sv_accelerate").AddChangeHook(acceleratesetting);
	FindConVar("sv_maxvelocity").AddChangeHook(velocitysetting);

	AutoExecConfig_SetCreateDirectory(true);
	AutoExecConfig_SetCreateFile(true);
	AutoExecConfig_SetFile("ez_config");

	i_airaccel = AutoExecConfig_CreateConVar("airaccelerate", "2000", "specifies value of airaccelerate", 0, true, 0.00, true, 10000.0);
	i_accel = AutoExecConfig_CreateConVar("accelerate", "10", "specifies value of accelerate", 0, true, 0.00, true, 100.0);
	i_maxvel = AutoExecConfig_CreateConVar("maxvel", "10000", "specifies value of max_velocity", 0, true, 0.00, true, 10000.0);

	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();
}

public void airacceleratesetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (convar.IntValue != i_airaccel.IntValue)
		convar.IntValue = i_airaccel.IntValue;
}

public void acceleratesetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (convar.IntValue != i_accel.IntValue)
		convar.IntValue = i_accel.IntValue;
}

public void velocitysetting(ConVar convar, const char[] oldValue, const char[] newValue)
{	
	char szMapName[128];
	GetCurrentMap(szMapName, sizeof(szMapName));

	//IF THE MAPS IS NOT SUPOSED TO HAVE A MAXVEL;
	if(FindStringInArray(g_MapListWhiteList, szMapName) == -1){
		if (convar.IntValue != i_maxvel.IntValue)
			convar.IntValue = i_maxvel.IntValue;
	}
	else{
		convar.IntValue = 3500;
	}
}
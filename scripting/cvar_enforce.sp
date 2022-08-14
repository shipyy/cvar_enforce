#include <autoexecconfig>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

#define MAXVEL_MAPS_PATH "configs/surftimer/maxvel_maps.txt"

char szMapName[128];

ConVar i_airaccel;
ConVar i_accel;
ConVar i_maxvel;

StringMap MaxVelMap;

int custom_maxvel = -1;

public Plugin myinfo =
{
	name        = "Cvar Enforce",
	author      = "shipy",
	description = "enforce cvars on maps with hardcoded settings",
	version     = "2.0.1",
	url         = "https://github.com/shipyy/cvar_enforce"
};

public void OnMapStart()
{	
	MaxVelMap = new StringMap();

	GetCurrentMap(szMapName, sizeof(szMapName));
	
	char sPath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, sizeof(sPath), "%s", MAXVEL_MAPS_PATH);
	File max_vel_maps = OpenFile(sPath, "r");

	char line[128];
	if (max_vel_maps != null) {

		while (!IsEndOfFile(max_vel_maps) && ReadFileLine(max_vel_maps, line, sizeof(line))) {

			if (StrContains(line, "//", false) == 0 || IsNullString(line) || strlen(line) == 0)
				continue;

			TrimString(line);

			char line_pieces[2][128];
			ExplodeString(line, ":", line_pieces, sizeof(line_pieces), sizeof(line_pieces[]));

			MaxVelMap.SetString(line_pieces[0], line_pieces[1]);
		}

	}
	else {
		LogError("[SurfTimer] %s not found", MAXVEL_MAPS_PATH);
	}

	if (max_vel_maps != null) {
		CloseHandle(max_vel_maps);
	}

	//check if the map is in the whitelist
	char szMaxVel[16];

	//if the map is in the whitelist
	if (MaxVelMap.GetString(szMapName, szMaxVel, sizeof(szMaxVel))) {
		custom_maxvel = StringToInt(szMaxVel);
	}

	AutoExecConfig_SetCreateDirectory(true);
	AutoExecConfig_SetCreateFile(true);
	AutoExecConfig_SetFile("cvar_enforce");

	i_airaccel = AutoExecConfig_CreateConVar("airaccelerate", "2000", "specifies value of airaccelerate", 0, true, 0.00, true, 10000.0);
	i_accel = AutoExecConfig_CreateConVar("accelerate", "10", "specifies value of accelerate", 0, true, 0.00, true, 100.0);
	i_maxvel = AutoExecConfig_CreateConVar("maxvel", "10000", "specifies value of max_velocity", 0, true, 0.00, true, 10000.0);

	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();

	FindConVar("sv_airaccelerate").AddChangeHook(airacceleratesetting);
	FindConVar("sv_accelerate").AddChangeHook(acceleratesetting);
	FindConVar("sv_maxvelocity").AddChangeHook(velocitysetting);
}

public void airacceleratesetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (convar.IntValue != i_airaccel.IntValue) {
		convar.IntValue = i_airaccel.IntValue;
	}
}

public void acceleratesetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (convar.IntValue != i_accel.IntValue) {
		convar.IntValue = i_accel.IntValue;
	}
}

public void velocitysetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	char szMaxVel[16];

	//IF THE MAPS IS NOT SUPOSED TO HAVE A MAXVEL;
	if (!MaxVelMap.GetString(szMapName, szMaxVel, sizeof(szMaxVel))) {
		if (convar.IntValue != i_maxvel.IntValue) {
			convar.IntValue = i_maxvel.IntValue;
		}
	}
	else {
		convar.IntValue = custom_maxvel;
	}
}
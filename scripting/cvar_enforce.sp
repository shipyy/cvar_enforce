#include <autoexecconfig>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

#define MAXVEL_MAPS_PATH "configs/maxvel_maps.txt"

char szMapName[128];

ConVar i_airaccel;
ConVar i_accel;
ConVar i_maxvel;

ConVar b_Use_airaccel;
ConVar b_Use_accel;
ConVar b_Use_maxvel;

ConVar b_Use_Custom_maxvel;

StringMap MaxVelMap;

int custom_maxvel = -1;

public Plugin myinfo =
{
	name        = "Cvar Enforce",
	author      = "shipy",
	description = "enforce cvars on maps with hardcoded settings",
	version     = "2.1.1",
	url         = "https://github.com/shipyy/cvar_enforce"
};

public void OnMapStart()
{
	AutoExecConfig_SetCreateDirectory(true);
	AutoExecConfig_SetCreateFile(true);
	AutoExecConfig_SetFile("cvar_enforce");

	i_airaccel = AutoExecConfig_CreateConVar("airaccelerate", "2000", "specifies value of airaccelerate", 0, true, 0.00, true, 10000.0);
	i_accel = AutoExecConfig_CreateConVar("accelerate", "10", "specifies value of accelerate", 0, true, 0.00, true, 100.0);
	i_maxvel = AutoExecConfig_CreateConVar("maxvel", "10000", "specifies value of max_velocity", 0, true, 0.00, true, 10000.0);

	b_Use_airaccel = AutoExecConfig_CreateConVar("use_airaccelerate", "1", "(0/1) Use base airaccelerate", 1, true, 0.00, true, 1.0);
	b_Use_accel = AutoExecConfig_CreateConVar("use_accelerate", "1", "(0/1) Use base accelerate", 1, true, 0.00, true, 1.0);
	b_Use_maxvel = AutoExecConfig_CreateConVar("use_maxvel", "1", "(0/1) Use base maxvelocity", 1, true, 0.00, true, 1.0);
	b_Use_Custom_maxvel = AutoExecConfig_CreateConVar("use_custom_maxvel", "1", "(0/1) Use custom maxvelocity from maxvel_maps.txt )", 1, true, 0.00, true, 1.0);

	AutoExecConfig_ExecuteFile();
	AutoExecConfig_CleanFile();

	SetConVars();
}

public void SetConVars()
{
	//SETTINGS
	PrintToServer("========== [CVAR ENFORCE] ==========");
	PrintToServer("Force AirAccelerate: %b | Value: %d ", b_Use_airaccel.BoolValue, i_airaccel.IntValue);
	PrintToServer("Force Accelerate: %b | Value: %d", b_Use_accel.BoolValue, i_accel.IntValue);
	PrintToServer("Force MaxVelocity: %b | Value: %d", b_Use_maxvel.BoolValue, i_maxvel.IntValue);

	if ( b_Use_airaccel.BoolValue )
		FindConVar("sv_airaccelerate").AddChangeHook(airacceleratesetting);

	if ( b_Use_accel.BoolValue )
		FindConVar("sv_accelerate").AddChangeHook(acceleratesetting);

	if ( b_Use_maxvel.BoolValue ) {
		FindConVar("sv_maxvelocity").AddChangeHook(velocitysetting);
	}

	if ( b_Use_Custom_maxvel.BoolValue ) {
		//PATH TO CONFIGS/MAXVEL_MAPS.TXT
		char sPath[PLATFORM_MAX_PATH];
		BuildPath(Path_SM, sPath, sizeof(sPath), "%s", MAXVEL_MAPS_PATH);
		File max_vel_maps = OpenFile(sPath, "r");

		//LOAD FILE MAXVELS TO STRINGMAP
		MaxVelMap = new StringMap();
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
			LogError("[CVAR ENFORCE] %s not found", MAXVEL_MAPS_PATH);
		}

		if (max_vel_maps != null) {
			CloseHandle(max_vel_maps);
		}

		//check if the map is in the whitelist
		char szMaxVel[16];

		//if the map is in the whitelist
		GetCurrentMap(szMapName, sizeof(szMapName));
		if (MaxVelMap.GetString(szMapName, szMaxVel, sizeof(szMaxVel))) {
			custom_maxvel = StringToInt(szMaxVel);
			PrintToServer("Specific Map MaxVelocity! | Value: %d", custom_maxvel);
		}

		SetConVarInt(FindConVar("sv_maxvelocity"), custom_maxvel, true, true);
	}

	PrintToServer("====================================");
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
		if ( b_Use_maxvel.BoolValue ) {
			if (convar.IntValue != i_maxvel.IntValue) {
				convar.IntValue = i_maxvel.IntValue;
			}
		}
	}
	else {
		convar.IntValue = custom_maxvel;
	}
}
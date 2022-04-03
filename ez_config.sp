#include <autoexecconfig>
#include <sdkhooks>
#include <sdktools>
#include <sourcemod>
#pragma newdecls required
#pragma semicolon 1

ConVar i_maxvel;
ConVar i_airaccel;
ConVar i_accel;

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
	FindConVar("sv_airaccelerate").AddChangeHook(airacceleratesetting);
	FindConVar("sv_accelerate").AddChangeHook(acceleratesetting);
	FindConVar("sv_maxvelocity").AddChangeHook(velsetting);

	AutoExecConfig_SetCreateDirectory(true);
	AutoExecConfig_SetCreateFile(true);
	AutoExecConfig_SetFile("ez_config");

	i_maxvel   = AutoExecConfig_CreateConVar("value_of_maxvelocity", "10000", "specifies value of maxvelocity", 0, true, 0.00, true, 10000.0);
	i_airaccel = AutoExecConfig_CreateConVar("value_of_airaccelerate", "2000", "specifies value of airaccelerate", 0, true, 0.00, true, 10000.0);
	i_accel    = AutoExecConfig_CreateConVar("value_of_accelerate", "10", "specifies value of accelerate", 0, true, 0.00, true, 100.0);

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

public void velsetting(ConVar convar, const char[] oldValue, const char[] newValue)
{
	if (convar.IntValue != i_maxvel.IntValue)
		convar.IntValue = i_maxvel.IntValue;
}
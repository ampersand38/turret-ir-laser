#include "script_component.hpp"
/*
 * Author: Ampersand
 * Stop blind fire
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * true call til_main_fnc_stop
 */

if (isNull GVAR(dummy)) exitWith {};

// Turn off dummy light/laser
if (GVAR(isFlashlightOn)) then { GVAR(dummy) action ["GunLightOff", GVAR(dummy)]; };
if (GVAR(isIRLaserOn)) then { GVAR(dummy) action ["IRLaserOff", GVAR(dummy)]; };

// Set unit state
private _loadout = getUnitLoadout GVAR(dummy);
private _unitLoadout = getUnitLoadout GVAR(unit);
_unitLoadout set [GVAR(loadoutIndex), _loadout select GVAR(loadoutIndex)];
private _currentVisionMode = currentVisionMode GVAR(unit);

GVAR(unit) setUnitLoadout _unitLoadout;
GVAR(unit) selectWeapon GVAR(endWeapon);
[{GVAR(unit) selectWeapon GVAR(endWeapon);}] call CBA_fnc_execNextFrame;
if (_currentVisionMode > 0) then { GVAR(unit) action ["nvGoggles", GVAR(unit)]; };
if (GVAR(isFlashlightOn)) then { GVAR(unit) action ["GunLightOn", GVAR(unit)]; };
if (GVAR(isIRLaserOn)) then { GVAR(unit) action ["IRLaserOn", GVAR(unit)]; };

// Clean up
{ GVAR(unit) removeEventHandler _x; } forEach GVAR(eventHandlers);
deleteVehicle GVAR(dummy);
#include "..\initVars.hpp"

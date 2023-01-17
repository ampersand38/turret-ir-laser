#include "script_component.hpp"
/*
 * Author: Ampersand
 * Toggles the IR laser pointer for a turret on a vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret <ARRAY>
 *
 * Return Value:
 * Success
 *
 * Example:
 * [_vehicle, _turretPath] call til_main_fnc_IRLaserToggle
 */

params ["_vehicle", "_turret"];

private _vehicleTurretID = format ["%1%2", _vehicle call BIS_fnc_netId, _turret];

if (_vehicleTurretID in GVAR(activeLasers)) exitWith {
    GVAR(activeLasers) deleteAt _vehicleTurretID;
};

private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;
private _pov = getText (_turretConfig >> "memoryPointGunnerOptics");

private _laserInfo = [_vehicle];

if (_pov == "pip0_pos") then {
    _laserInfo = _laserInfo + ["pip0_dir", _pov];
} else {
    private _gunBeg = getText (_turretConfig >> "gunBeg");
    private _gunEnd = getText (_turretConfig >> "gunEnd");
    _laserInfo = _laserInfo + [_gunBeg, _gunEnd];
};

//GVAR(activeLasers) set [_vehicleTurretID, [_vehicle, _selectionBeg, _selectionEnd]];
GVAR(activeLasers) set [_vehicleTurretID, _laserInfo];

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

private _laserInfo = [_vehicle];

if (_turret isEqualTo [-1]) exitWith { // Pilot
    getPilotCameraTarget _vehicle params ["_pilotCamTracking", "_pilotCamTargetPos", "_pilotCamTarget"];
    private _gunBeg = getText (configOf _vehicle >> "memoryPointDriverOptics");
    private _gunEnd = if (_pilotCamTarget isEqualTo objNull) then {
        _pilotCamTargetPos
    } else {
        _pilotCamTarget
    };
    _laserInfo = _laserInfo + [_gunBeg, _gunEnd];
    GVAR(activeLasers) set [_vehicleTurretID, _laserInfo];
};

private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;
private _pov = getText (_turretConfig >> "memoryPointGunnerOptics");

if (_pov == "pip0_pos") then {
    _laserInfo = _laserInfo + [_pov, "pip0_dir"];
} else {
    private _gunBeg = getText (_turretConfig >> "gunBeg");
    private _gunEnd = getText (_turretConfig >> "gunEnd");
    _laserInfo = _laserInfo + [_gunEnd, _gunBeg];
};

//GVAR(activeLasers) set [_vehicleTurretID, [_vehicle, _selectionBeg, _selectionEnd]];
GVAR(activeLasers) set [_vehicleTurretID, _laserInfo];

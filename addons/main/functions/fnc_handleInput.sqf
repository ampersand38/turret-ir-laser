#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles input Turret IR Laser (Toggle)
 *
 * Arguments:
 * 0: Input <BOOLEAN>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * true call til_main_fnc_handleInput
 */

if (visibleMap) exitWith {};
if (!isNull curatorCamera) exitWith { // Zeus
    private _turrets = [];
    private _vehicles = [];
    {
        if (!alive _x || {isPlayer _x}) then {continue;};

        private _vehicle = vehicle _x;
        if (!alive _vehicle || {_vehicle in _vehicles}) then {continue;};

        if (_x isKindOf "CAManBase") then {
            private _unit = _x;
            private _turret = _vehicle unitTurret _unit;
            if (
                _turret in allTurrets _vehicle || // Gunner
                {_turret isEqualTo [-1] && {(getPilotCameraTarget _vehicle select 0)}} // Pilot
            ) then {
                [_vehicle, _turret] call FUNC(IRLaserToggle);
            };
        } else {
            // Vehicle
            if (crew _x isEqualTo []) then {continue;};
            _vehicles pushBack _vehicle;
            {
                if !(alive (_vehicle turretUnit _x)) then {continue;};
                [_vehicle, _x] call FUNC(IRLaserToggle);
            } forEach allTurrets _vehicle;
            if (getPilotCameraTarget _vehicle select 0) then {
                [_vehicle, [-1]] call FUNC(IRLaserToggle);
            };
        };
    } forEach (curatorSelected select 0);
};

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
private _vehicle = vehicle _unit;

// Unit in uav control
if (
    _vehicle != cameraOn &&
    {getConnectedUAV _unit == cameraOn}
) then {
    _vehicle = cameraOn;
    _unit = getConnectedUAVUnit _unit;
};

if (
    _unit == _vehicle ||
    {!alive _unit || {!alive _vehicle}}
) exitWith {};

private _turret = _vehicle unitTurret _unit;

if (_turret isEqualTo [] || {(_vehicle getCargoIndex _unit) > -1}) exitWith {}; // Cargo
if (_turret isEqualTo [-1] && {!(getPilotCameraTarget _vehicle select 0)}) exitWith {
    systemChat format ["%1 IR laser failed: targeting pod not tracking.", _vehicle];
}; // Pilot

[QGVAR(IRLaserToggle), [_vehicle, _turret]] call cba_fnc_globalEvent;

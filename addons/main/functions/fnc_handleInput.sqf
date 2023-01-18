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
    {
        if (!alive _x) then {continue;};

        private _vehicle = vehicle _x;
        if (!alive _vehicle) then {continue;};

        if (_x isKindOf "CAManBase") then {
            private _unit = _x;
            private _turret = _vehicle unitTurret _x;
            if (_turret isEqualTo [] || {(_vehicle getCargoIndex _unit) == -1}) then {continueWith {false}}; // Cargo
            if (_turret isEqualTo [-1] && {!(getPilotCameraTarget _vehicle select 0)}) then {continueWith {false}}; // Pilot
            [_vehicle, _turret] call FUNC(IRLaserToggle);
        } else {
            // Vehicle
            if ([0] in allTurrets _vehicle) then {
                [_vehicle, [0]] call FUNC(IRLaserToggle);
            };
        };
    } forEach curatorSelected;
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

[_vehicle, _turret] call FUNC(IRLaserToggle);

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

if (
    !isNull curatorCamera ||
    {!alive cameraOn ||
    {visibleMap}}
) exitWith {};

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

if (
    _turret isEqualTo [] ||
    {_turret isEqualTo [-1]}
) exitWith {};

[_vehicle, _turret] call FUNC(IRLaserToggle);

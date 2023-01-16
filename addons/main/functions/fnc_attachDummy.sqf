#include "script_component.hpp"
/*
 * Author: Ampersand
 * Returns position a given distance in front of muzzle of the weapon proxy
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Direction <NUMBER> -1: Left, 1: Right
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [1] call til_main_fnc_attachDummy
 */

#define COUNT_POSITIONS 4
#define COUNT_WEAPONS 3

params [["_direction", 0]];

if (isNull GVAR(dummy)) exitWith {};

GVAR(direction) = 0 max (GVAR(direction) + _direction) min (COUNT_POSITIONS - 1);

private _index = GVAR(loadoutIndex) * COUNT_POSITIONS + GVAR(direction);
if (_index < 0 || {_index > (COUNT_POSITIONS * COUNT_WEAPONS - 1)}) exitWith {};

private _offset = [
    // Rifle
    [0.0,0.13,   -0.02], // Left
    [0.0,0.24,  0.22], // Forward
    [0.0,0.17,  -0.02], // Down
    [0.1,0.22,  0.00], // Right
    // Launcher
    [0.2,0.2,0], // Left
    [0.3,0.1,0], // Forward
    [0.2,0.2,0], // Down
    [0.15,0.25,0.1], // Right
    // Handgun
    [-0.02,0.02,-0.05], // Left
    [0.02,0.3,0.02], // Forward
    [0.05,0,0.02], // Down
    [0.02,0.02,0.06] // Right
] select _index;

GVAR(vectorDirAndUp) = [
    // Rifle
    [[-1, 1, 0], [0, 0, 1]], // Left
    [[0, 1, 0], [0, 0, 1]], // Forward
    [[0, 1, -1], [0, 1, 1]], // Down
    [[1, 1, 0], [0, 0, 1]], // Right
    // Launcher
    [[0, 1, 1], [0, 0, 1]], // Left
    [[0, 1, 0], [0, 0, 1]], // Forward
    [[-1, 1, 0], [0, 0, 1]], // Down
    [[0, 1, -1], [0, 0, 1]],
    // Handgun
    [[0, 1, 0], [1, 1, 1]], // Left
    [[0, 1, 0], [0, 1, 1]], // Forward
    [[1, 3, -1], [0, 1, 1]], // Down
    [[0, 1, 0], [-1, 1, 1]] // Right
] select _index;
/*
private _offset = [
    // Rifle
    [-0.25, -1.2, -0.5],
    [0.21, -0.5, -1.34],
    [-0.5, -0.2, -1.34],
    // Launcher
    [-1.0, -0.8, 0.1],
    [-1.6, -0.1, -0.1],
    [-1.6, 0.2, 0.2],
    // Handgun
    [-1.1, -0.65, 0.85],
    [-0.2, -1.4, 0.7],
    [-0.73, -1.4, -0.17]
] select (GVAR(loadoutIndex) * 3 + _direction);

GVAR(vectorDirAndUp) = [
    // Rifle
    [[0, 1, -1], [0, 1, 1]],
    [[-1, 1, 0], [1, 1, 0]],
    [[1, 1, 0], [0, 0, 1]],
    // Launcher
    [[-1, 1, 0], [1, 1, 0]],
    [[0, 1, 1], [1, 0, 0]],
    [[0, 1, -1], [1, 0, 0]],
    // Handgun
    [[1, -1, -1], [1, 1, -1]],
    [[0, 0, -1], [0, 1, 0]],
    [[1, 0, 0], [0, 1, 0]]
] select (GVAR(loadoutIndex) * 3 + _direction);
*/
//GVAR(dummy) attachTo [_unit, [0,0,0], GVAR(proxy), true];
GVAR(dummy) attachTo [GVAR(unit), _offset, GVAR(proxy), true];
GVAR(dummy) setVectorDirAndUp GVAR(vectorDirAndUp);
/*
if (isNil QGVAR(axesHelper)) then {
    GVAR(axesHelper) = "Land_Laptop_unfolded_F" createVehicle [0,0,0];
};
GVAR(axesHelper) attachTo [GVAR(unit), [0,0,0], GVAR(proxy), true];
*/

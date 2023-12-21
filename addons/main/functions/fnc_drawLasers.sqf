#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws currently active laser pointers.
 *
 * Arguments:
 * -
 *
 * Return Value:
 * -
 *
 * Example:
 * call til_main_fnc_drawLasers
 */

{
    _y params ["_vehicle", "_pov"];

    private _lasDir = _vehicle selectionVectorDirAndUp [_pov, 1e15] param [0, []];

    if (
        !alive _vehicle
        || {_lasDir isEqualTo []}
    ) then {GVAR(activeLasers) deleteAt _x; continue;};

    _lasDir = _vehicle vectorModelToWorldVisual _lasDir;
    private _posBeg = _lasDir vectorAdd (_vehicle modelToWorldVisualWorld (_vehicle selectionPosition _pov));

    drawLaser [
        _posBeg,
        _lasDir,
        [100, 100, 100],
        [],
        1,
        1,
        -1,
        true
    ];
} forEach GVAR(activeLasers);

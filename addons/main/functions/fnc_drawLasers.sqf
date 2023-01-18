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
    _y params ["_vehicle", "_selectionBeg", "_selectionEnd"];

    if (!alive _vehicle) then {GVAR(activeLasers) deleteAt _x; continue;};

    //private _posBeg = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _selectionBeg);
    private _posBeg = (velocity _vehicle vectorMultiply diag_deltaTime) vectorAdd (_vehicle modelToWorldVisualWorld (_vehicle selectionPosition _selectionBeg));
    private _posEnd = if (_selectionEnd == "") then {
        // Pilot camera
        getPilotCameraTarget _vehicle params ["_pilotCamTracking", "_pilotCamTargetPos", "_pilotCamTarget"];
        if (!_pilotCamTracking) then {GVAR(activeLasers) deleteAt _x; continue;};

        if (_pilotCamTarget isEqualTo objNull) then {
            _pilotCamTargetPos;
        } else {
            _pilotCamTarget
        }
    } else {
        // Turret
        _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _selectionEnd)
    };

    //private _lasDir = _posBeg vectorDiff _posEnd;
    private _lasDir = _posEnd vectorDiff _posBeg;

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

#include "script_component.hpp"

if (hasInterface) then {
    addMissionEventHandler ["Draw3D", {call FUNC(drawLasers)}];

    [QGVAR(IRLaserToggle), {call FUNC(IRLaserToggle)}] call CBA_fnc_addEventHandler;
};

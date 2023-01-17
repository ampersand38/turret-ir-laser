#include "script_component.hpp"

if (hasInterface) then {
    addMissionEventHandler ["Draw3D", {call FUNC(drawLasers)}];
};

#include "script_component.hpp"

if (hasInterface) then {
    addUserActionEventHandler ["ReloadMagazine", "Activate", { call FUNC(stop) }];
    addUserActionEventHandler ["gear", "Activate", { call FUNC(stop) }];
    addUserActionEventHandler ["Action", "Activate", { call FUNC(stop) }];
    addUserActionEventHandler ["SwitchPrimary", "Activate", { [0] call FUNC(inputStop); }];
    addUserActionEventHandler ["SwitchSecondary", "Activate", { [1] call FUNC(inputStop); }];
    addUserActionEventHandler ["SwitchHandgun", "Activate", { [2] call FUNC(inputStop); }];
    addUserActionEventHandler ["switchWeapon", "Activate", { [3] call FUNC(inputStop); }];
    addUserActionEventHandler ["handgun", "Activate", { [4] call FUNC(inputStop); }];
};

#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QGVAR(dummy)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "";
        authors[] = {""};
        VERSION_CONFIG;
    };
};

#include "CfgDefaultKeysPresets.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgUserActions.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "UserActionGroups.hpp"
//#include "UserActionsConflictGroups.hpp"

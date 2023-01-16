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
 * true call til_main_fnc_inputTurretIRLaserToggle
 */

if (!isNull GVAR(dummy)) exitWith { call FUNC(stop) };

GVAR(unit) = call CBA_fnc_currentUnit;
if (!isNull objectParent GVAR(unit)) exitWith { call FUNC(stop) };

private _weapon = currentWeapon GVAR(unit);
GVAR(endWeapon) = _weapon;
private _cfg = configFile >> "CfgWeapons" >> _weapon;
private _weaponType = getNumber (_cfg >> "type"); // Rifle: 1, Pistol: 2, Launcher: 4
GVAR(loadoutIndex) = [1, 4, 2] find _weaponType; // loadout order
if (GVAR(loadoutIndex) < 0) exitWith { call FUNC(stop) };
private _unitLoadout = getUnitLoadout GVAR(unit);
GVAR(muzzle) = currentMuzzle GVAR(unit);
private _ammoCount = GVAR(unit) ammo GVAR(muzzle);
private _currentVisionMode = currentVisionMode GVAR(unit);
GVAR(isFlashlightOn) = GVAR(unit) isFlashlightOn _weapon;
GVAR(isIRLaserOn) = GVAR(unit) isIRLaserOn _weapon;

GVAR(proxy) = [
    "proxy:\a3\characters_f\proxies\weapon.001",
    //"weapon",
    "proxy:\a3\characters_f\proxies\launcher.001",
    //"launcher",
    "proxy:\a3\characters_f\proxies\pistol.001"
    //"RightHand"
] select GVAR(loadoutIndex);

// Prep dummy

/*
private _group = createGroup [side GVAR(unit), true];
//GVAR(dummy) = _group createUnit [QGVAR(dummy), [0, 0, 0], [], 0, "CAN_COLLIDE"];
GVAR(dummy) = _group createUnit ["B_Soldier_VR_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
[GVAR(dummy)] joinSilent _group;
_group setBehaviour "COMBAT";
*/
GVAR(dummy) = createAgent [QGVAR(dummy), [0, 0, 0], [], 0, "CAN_COLLIDE"];
//GVAR(dummy) = createAgent ["B_Soldier_VR_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
if (isNull GVAR(dummy)) exitWith {
    systemChat "could not create dummy";
};
private _loadout = getUnitLoadout GVAR(dummy);
_loadout set [GVAR(loadoutIndex), _unitLoadout select GVAR(loadoutIndex)];
GVAR(dummy) setUnitLoadout _loadout;
GVAR(dummy) disableAI "ALL";
GVAR(dummy) allowDamage false;
GVAR(dummy) switchmove format ["AmovPercMstpSrasW%1Dnon", ["rfl", "lnr", "pst"] select GVAR(loadoutIndex)];
if (GVAR(isFlashlightOn)) then {
    GVAR(dummy) action ["GunLightOn", GVAR(dummy)];
};
if (GVAR(isIRLaserOn)) then {
    GVAR(dummy) action ["IRLaserOn", GVAR(dummy)];
};
GVAR(dummy) addEventHandler ["Deleted", { call FUNC(stop) }];
[{
    [{
        (!GVAR(isFlashlightOn) && !GVAR(isIRLaserOn)) ||
        {GVAR(isFlashlightOn) && {GVAR(dummy) isFlashlightOn currentWeapon GVAR(dummy)}} ||
        {GVAR(isIRLaserOn) && {GVAR(dummy) isIRLaserOn currentWeapon GVAR(dummy)}}
    }, {
        [] call FUNC(attachDummy);
    }, nil, 2, {diag_log format ["Could not turn on laser/light"]}] call CBA_fnc_waitUntilAndExecute;
}, nil, 0.5] call CBA_fnc_waitAndExecute;

// Prep player unit
GVAR(FakeWeapon) = [
    QGVAR(FakeRifle),
    QGVAR(FakeLauncher),
    QGVAR(FakePistol)
] select GVAR(loadoutIndex);
private _fakeLoadout = _unitLoadout select GVAR(loadoutIndex);
    //[GVAR(FakeWeapon),"","","",[[], [QGVAR(1000Rnd_Mag), _unitLoadout select 0 select 4 select 1]] select (_ammoCount > 0),[],""],
    //[QGVAR(FakeLauncher),"","","",[[],[GVAR(Rocket_Mag),_unitLoadout select 1 select 4 select 1]] select (_ammoCount > 0),[],""],
    //[QGVAR(FakePistol),"","","",[[],[QGVAR(1000Rnd_Mag),_unitLoadout select 2 select 4 select 1]] select (_ammoCount > 0),[],""]
_fakeLoadout set [0, GVAR(FakeWeapon)];
_fakeLoadout set [1, ""];
_fakeLoadout set [2, ""];
_fakeLoadout set [3, ""];
if ((_fakeLoadout select 4) isNotEqualTo []) then {
    (_fakeLoadout select 4) set [0,
        [
            QGVAR(1000Rnd_Mag),
            QGVAR(Rocket_Mag),
            QGVAR(1000Rnd_Mag)
        ] select GVAR(loadoutIndex)
    ];
};

_unitLoadout set [GVAR(loadoutIndex), _fakeLoadout];
GVAR(unit) setUnitLoadout _unitLoadout;
GVAR(unit) selectWeapon GVAR(FakeWeapon);
if (_currentVisionMode > 0) then {
    GVAR(unit) action ["nvGoggles", GVAR(unit)];
};

GVAR(eventHandlers) pushBack ["Fired", GVAR(unit) addEventHandler ["Fired", {
	//params ["_unit", "_weapon", "_muzzle", "_fireMode", "_ammo", "_magazine", "_projectile", "_gunner"];
	params ["", "", "", "_fireMode", "", "", "_projectile"];
    GVAR(dummy) forceWeaponFire [GVAR(muzzle), _fireMode];
    deleteVehicle _projectile;
    //if (GVAR(unit) ammo currentMuzzle GVAR(unit) == 0) then { deleteVehicle GVAR(dummy); };
}]];
GVAR(eventHandlers) pushBack ["AnimStateChanged", GVAR(unit) addEventHandler ["AnimStateChanged", {
	params ["_unit", "_anim"];
    private _currWeapon = currentWeapon GVAR(unit);
    if (
        currentWeapon GVAR(unit) != GVAR(FakeWeapon)
    ) then {
        GVAR(endWeapon) = _currWeapon;
        call FUNC(stop);
    };
}]];

/*

{
  _x addCuratorEditableObjects [[GVAR(dummy)], true];
} forEach allCurators;
BIS_tracedShooter = nil;
[GVAR(dummy), 10] call BIS_fnc_traceBullets;

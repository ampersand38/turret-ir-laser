class UserActionsConflictGroups {
    class ActionGroups {
        GVAR(TurretIRLaserActionGroup)[] = {QGVAR(TurretIRLaser)};
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"TAG_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        GVAR(TurretIRLaserActionGroupCollisions)[] = {QGVAR(TurretIRLaserActionGroup), "VehBasic", "Turret"};
    };
};

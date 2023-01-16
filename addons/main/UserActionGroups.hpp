class UserActionGroups
{
	class GVAR(TurretIRLaser) // Unique classname of your category.
	{
		name = CSTRING(TurretIRLaser); // Display name of your category.
		isAddon = 1;
		group[] = { // List of all actions inside this category.
            QGVAR(AimUp),
            QGVAR(AimDown),
            QGVAR(AimLeft),
            QGVAR(AimRight),
            QGVAR(TurretIRLaserToggle),
            QGVAR(TestInput)
        };
	};
};

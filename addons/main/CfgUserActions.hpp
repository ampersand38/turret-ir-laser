class CfgUserActions {
    class GVAR(TurretIRLaser) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(TurretIRLaserToggle);
        tooltip = CSTRING(TurretIRLaserToggle_ToolTip);
        onActivate = QUOTE(call FUNC(handleInput));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputTurretIRLaserToggle));		// _this is always false.
        //onAnalog = QUOTE(call FUNC(inputTurretIRLaserToggle));	// _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
};

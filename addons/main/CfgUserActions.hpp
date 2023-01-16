class CfgUserActions {
    class GVAR(IRLaserToggle) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "str_a3_cfgweapons_acc_pointer_ir0";
        tooltip = "str_a3_cfgweapons_use_pointer_ir0;
        onActivate = QUOTE(call FUNC(inputIRLaserToggle));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputTurretIRLaserToggle));		// _this is always false.
        //onAnalog = QUOTE(call FUNC(inputTurretIRLaserToggle));	// _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
};

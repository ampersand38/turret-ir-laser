class CfgVehicles {
    //class CAManBase;
    //class GVAR(dummy): CAManBase {
    class B_Soldier_VR_F;
    class GVAR(dummy): B_Soldier_VR_F {
    	author = "Ampersand";
    	_generalMacro = QGVAR(dummy);
    	threat[] = {0.8, 0.1, 0.1};
    	model = QPATHTOF(data\dummy.p3d);
    	modelSides[] = {6};
    	picture = "";
    	Icon = "iconManVirtual";
    	role = "Unarmed";
    	displayName = "";
    };
};

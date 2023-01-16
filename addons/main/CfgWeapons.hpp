/// All firemodes, to be sure
class Mode_SemiAuto;
class Mode_Burst;
class Mode_FullAuto;

class CfgWeapons {
	class Rifle_Base_F;
	class GVAR(FakeRifle): Rifle_Base_F /// Just basic values common for all testing rifle variants
	{
        author = "Ampersand";
        scope = 2;
        showToPlayer = 0;
		displayName = "Turret IR Laser";
        descriptionShort = "Invisible weapon to hold while blind-firing.";
		model = QPATHTOF(data\rifle.p3d);

		picture = "\a3\ui_f\data\GUI\Cfg\Hints\WeaponResting_ca.paa";
		UiPicture = "\A3\Weapons_F\Data\UI\icon_regular_CA.paa";
		weaponInfoType = "RscWeaponEmpty";

		muzzles[] = {this}; /// to be able to switch between bullet muzzle and TGL
		magazines[] = {GVAR(1000Rnd_Mag)};
		reloadAction = ""; /// MX hand animation actually fits this rifle well
		/// positive value defines speed of the muzzle independent on the magazine setting, negative value is a coefficient of magazine initSpeed
		initSpeed = -1; /// this means that initSpeed of magazine is used

		handAnim[] = {"OFP2_ManSkeleton", "\A3\Weapons_F\Rifles\MX\data\Anim\MX_gl.rtm"}; /// MX hand animation actually fits this rifle well
		dexterity = 1.8;

        //caseless ammo//
		caseless[] = {"",1,1,1};  /// no sound of ejected brass
		soundBullet[] = {caseless,1};

		selectionFireAnim = ""; /// are we able to get rid of all the zaslehs?

		modes[] = {Single, FullAuto}; /// Includes fire modes for AI

    ////////////////////////////////////////////////////// NO OPTICS ///////////////////////////////////////////////////////////

		class Single: Mode_SemiAuto /// Pew
		{
			// the new parameter to distinguish muzzle accessories type
			sounds[] = {};
			reloadTime = 0.096; /// means some 625 rounds per minute
			recoil = "recoil_zafir"; /// defined in cfgRecoils
			recoilProne = "assaultRifleBase"; /// defined in cfgRecoils
		};
		class FullAuto: Mode_FullAuto /// Pew-pew-pew-pew-pew
		{
			sounds[] = {};
			reloadTime = 0.096;
			recoil = "recoil_zafir"; /// defined in cfgRecoils
			recoilProne = "assaultRifleBase"; /// defined in cfgRecoils
		};
	};

    class Pistol_Base_F;
    class GVAR(FakePistol): Pistol_Base_F
    {
        author = "Ampersand";
        _generalMacro = QGVAR(FakePistol);
        scope = 2;
        showToPlayer = 0;
		displayName = "Turret IR Laser";
        descriptionShort = "Invisible weapon to hold while blind-firing.";
		model = QPATHTOF(data\rifle.p3d);

		picture = "\a3\ui_f\data\GUI\Cfg\Hints\WeaponResting_ca.paa";
		UiPicture = "\A3\Weapons_F\Data\UI\icon_regular_CA.paa";
		weaponInfoType = "RscWeaponEmpty";

		muzzles[] = {this}; /// to be able to switch between bullet muzzle and TGL
		magazines[] = {GVAR(1000Rnd_Mag)};
		reloadAction = ""; /// MX hand animation actually fits this rifle well
		/// positive value defines speed of the muzzle independent on the magazine setting, negative value is a coefficient of magazine initSpeed
		initSpeed = -1; /// this means that initSpeed of magazine is used
        recoil = "recoil_pistol_zubr";
        drySound[] = {"A3\Sounds_F\arsenal\weapons\Pistols\Zubr\dry_Zubr", 0.398107, 1, 20};
        modes[] = {"Single"};
        class Single: Mode_SemiAuto {
            recoil = "recoil_pistol_heavy";
            recoilProne = "recoil_prone_pistol_heavy";
            sounds[] = {};
        };
        inertia = 0.3;
        dexterity = 1.7;
        maxZeroing = 50;
    };

    class launch_RPG7_F;
    class GVAR(FakeLauncher): launch_RPG7_F {
        author = "Ampersand";
        scope = 2;
        showToPlayer = 0;
        displayName = "Turret IR Laser";
        descriptionShort = "Invisible weapon to hold while blind-firing.";
        hiddenSelectionsTextures[] = {""};
        magazines[] = {"RPG7_F", QGVAR(Rocket_Mag)};
		picture = "\a3\ui_f\data\GUI\Cfg\Hints\WeaponResting_ca.paa";
		UiPicture = "\A3\Weapons_F\Data\UI\icon_at_CA.paa";
		weaponInfoType = "RscWeaponEmpty";
        handAnim[] = {"OFP2_ManSkeleton", "\A3\Weapons_F\Launchers\NLAW\Data\Anim\NLAW.rtm"};
    	class Single: Mode_SemiAuto
    	{
    		recoil = "recoil_single_nlaw";
            sounds[] = {};
    	};
        class GunParticles {};
    };
};

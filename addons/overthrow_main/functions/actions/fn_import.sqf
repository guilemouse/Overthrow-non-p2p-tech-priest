if (OT_taking) exitWith {};

OT_taking = true;
private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];
private _num = _this select 0;
private _price = [OT_nation,_cls,100] call OT_fnc_getPrice;
private _total = (_num * _price);
private _veh = (vehicle player);

if((player getVariable ["money",0]) < _total) exitWith {
	format["You need $%1",[_total, 1, 0, true] call CBA_fnc_formatNumber] call OT_fnc_notifyMinor;
	OT_taking = false;
};

private _found_truck = false;
private _i_count = count (OT_all_trucks);
for [{private _i = 0}, {_i < _i_count}, {_i = _i + 1}] do { 
	if (_veh isKindOf (OT_all_trucks select _i)) then {
		_found_truck = true;
		_i = _i_count;
	};
};

//if vehicle is not Truck_F and if vehicle cannot add more.
//if ((!(_veh isKindOf "Truck_F")) && (!(_veh canAdd [_cls,_num]))) exitWith {
if (!_found_truck && (!(_veh canAdd [_cls,_num]))) exitWith {
	hint "This vehicle cannot fit that, use a bigger one for more storage";
	OT_taking = false;
};

[-_total] call OT_fnc_money;

OT_taking = false;

if(_cls isKindOf ["Rifle",configFile >> "CfgWeapons"]) exitWith {
	_veh addWeaponCargoGlobal [_cls,_num];
};
if(_cls isKindOf ["Launcher",configFile >> "CfgWeapons"]) exitWith {
	_veh addWeaponCargoGlobal [_cls,_num];
};
if(_cls isKindOf ["Pistol",configFile >> "CfgWeapons"]) exitWith {
	_veh addWeaponCargoGlobal [_cls,_num];
};
if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
	_veh addMagazineCargoGlobal [_cls,_num];
};
if(_cls isKindOf "Bag_Base") exitWith {
	_veh addBackpackCargoGlobal [_cls,_num];
};
_veh addItemCargoGlobal [_cls,_num];

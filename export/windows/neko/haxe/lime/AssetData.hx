package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/Hope.oep", "assets/data/Hope.oep");
			type.set ("assets/data/Hope.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/level1.oel", "assets/data/level1.oel");
			type.set ("assets/data/level1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/level2.oel", "assets/data/level2.oel");
			type.set ("assets/data/level2.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/bg.png", "assets/images/bg.png");
			type.set ("assets/images/bg.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Bullet.png", "assets/images/Bullet.png");
			type.set ("assets/images/Bullet.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Ene1.png", "assets/images/Ene1.png");
			type.set ("assets/images/Ene1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Ene2.png", "assets/images/Ene2.png");
			type.set ("assets/images/Ene2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Ene3.png", "assets/images/Ene3.png");
			type.set ("assets/images/Ene3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Ene4.png", "assets/images/Ene4.png");
			type.set ("assets/images/Ene4.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Granyan.png", "assets/images/Granyan.png");
			type.set ("assets/images/Granyan.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Missile.png", "assets/images/Missile.png");
			type.set ("assets/images/Missile.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Nave.png", "assets/images/Nave.png");
			type.set ("assets/images/Nave.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Option.png", "assets/images/Option.png");
			type.set ("assets/images/Option.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Shield.png", "assets/images/Shield.png");
			type.set ("assets/images/Shield.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tileset.png", "assets/images/tileset.png");
			type.set ("assets/images/tileset.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Up.png", "assets/images/Up.png");
			type.set ("assets/images/Up.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/UpBar.png", "assets/images/UpBar.png");
			type.set ("assets/images/UpBar.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData

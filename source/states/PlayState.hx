package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.Player;

class PlayState extends FlxState
{
	private var level:FlxTilemap;
	private var player:Player;
	override public function create():Void
	{
		super.create();
		
		player = new Player();
		
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level1__oel);
		level = loader.loadTilemap(AssetPaths.galleta__png , 16, 16, "estructura");
		loader.loadEntities(drawEntities, "entidades");
		
		FlxG.camera.follow(player);
		FlxG.camera.setScrollBounds(0, level.width, 0, level.height);
		FlxG.worldBounds.set(0, 0, level.width, level.height);
		
		level.setTileProperties(0, FlxObject.NONE);
		level.setTileProperties(1, FlxObject.ANY);
		level.setTileProperties(2, FlxObject.NONE);
		
		add(level);
		add(player);		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(level, player);
	}
	
	private function drawEntities( entityName:String, entityData:Xml):Void
	{
		if (entityName == "player")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			player = new Player(X, Y);
			player.makeGraphic(16, 16, 0xFF00FF00);
			player.velocity.x = 64;
		}
	}
}

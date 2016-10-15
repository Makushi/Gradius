package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import sprites.Boss;
import sprites.Bullet;
import sprites.Player;
import sprites.Ene1;
import sprites.Ene2;
import sprites.Ene3;
import sprites.Ene4;
import sprites.UpBar;
import sprites.Item;

class PlayState extends FlxState
{
	private var mapTiles:FlxTilemap;
	private var bgTiles:FlxTilemap;
	private var player:Player;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var enemyBullets:FlxTypedGroup<Bullet>;
	public var enemiesType1:FlxTypedGroup<Ene1>;
	public var enemiesType2:FlxTypedGroup<Ene2>;
	public var enemiesType3:FlxTypedGroup<Ene3>;
	public var enemiesType4:FlxTypedGroup<Ene4>;
	public var boss:Boss;
	public var powerUps:FlxTypedGroup<Item>;
	public var screenPositionX:Float = 0;
	public var screenSpeed:Float = 1;
	public var scroll:Bool = true;
	private var scoreText:FlxText;
	private var highScoreText:FlxText;
	private var livesCounter:FlxText;
	private var turretFireTimer:FlxTimer;
	private var themeSong:FlxSound;
	private var powerUpSound:FlxSound;
	
	override public function create():Void
	{
		super.create();
		themeSong = FlxG.sound.load(AssetPaths.ThemeSong__wav, 1, true);
		themeSong.play();
		powerUpSound = FlxG.sound.load(AssetPaths.Powerup__wav);
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level2__oel);
		
		mapTiles = loader.loadTilemap(AssetPaths.tileset__png , 16, 16, "tiles");
		bgTiles = loader.loadTilemap(AssetPaths.bg__png , 16, 16, "bg");
		add(bgTiles);
		add(mapTiles);
		
		enemyBullets = new FlxTypedGroup<Bullet>();		
		add(enemyBullets);
		
		enemiesType1 = new FlxTypedGroup<Ene1>();
		add(enemiesType1);
		
		enemiesType2 = new FlxTypedGroup<Ene2>();
		add(enemiesType2);
		
		enemiesType3 = new FlxTypedGroup<Ene3>();
		add(enemiesType3);
		
		enemiesType4 = new FlxTypedGroup<Ene4>();
		add(enemiesType4);
		
		powerUps = new FlxTypedGroup<Item>();
		add(powerUps);
		
		loader.loadEntities(drawEntities, "entities");
		
		FlxG.camera.setScrollBounds(0, mapTiles.width, 0, mapTiles.height);
		FlxG.camera.scroll = new FlxPoint(player.x,player.y);
		scroll = true;
		
		FlxG.worldBounds.set(0, 0, mapTiles.width, mapTiles.height);
				
		scoreText = new FlxText(90, Reg.ScreenHeight - 20, "Score : " + Reg.score);
		add(scoreText);
		highScoreText = new FlxText(150, Reg.ScreenHeight - 20, "HighScore : " + Reg.highScore);
		add(highScoreText);
		livesCounter = new FlxText(10, Reg.ScreenHeight - 20, " Lives : " + Reg.playerLives);
		add(livesCounter);
		
		Reg.ub = new UpBar(64, 2);
		add(Reg.ub);

		turretFireTimer = new FlxTimer();
		turretFireTimer.start(2, TurretsFire, 0);
		Reg.playerCoords = new FlxPoint(player.x, player.y);
		
		mapTiles.setTileProperties(1, FlxObject.ANY);
		mapTiles.setTileProperties(2, FlxObject.ANY);
		mapTiles.setTileProperties(3, FlxObject.ANY);
		mapTiles.setTileProperties(4, FlxObject.ANY);
		mapTiles.setTileProperties(5, FlxObject.ANY);
		mapTiles.setTileProperties(6, FlxObject.ANY);
		mapTiles.setTileProperties(7, FlxObject.ANY);
		mapTiles.setTileProperties(8, FlxObject.ANY);
		mapTiles.setTileProperties(9, FlxObject.ANY);
		mapTiles.setTileProperties(10, FlxObject.ANY);
		mapTiles.setTileProperties(11, FlxObject.ANY);
		

	}
		
	private function TurretsFire(Timer:FlxTimer):Void
	{
		for (enemy in enemiesType4)
		{
			if (enemy.alive && InCameraBounds(enemy))
			{
				enemy.AgregarDisp(player.x, player.y);
			}
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(mapTiles, player);
		FlxG.collide(mapTiles, playerBullets);
		FlxG.collide(mapTiles, enemyBullets);

		if (player.alive)
		{
			CameraMovement();
			PlayerMovementInCameraBounds();
			PlayerBulletsInCameraBounds();
			EnemyBulletsInCameraBounds();
			PllayerStageCollision();	
			ActivateEnemies();
			EnemiesInCamera();
			Collisions();	
		}
		
		//Reg.playerCoords.x = player.x;
		//Reg.playerCoords.y = player.y;
	}
	
	private function ActivateEnemies()
	{
		for (enemy in enemiesType1)
		{
			if (InCameraBounds(enemy))
			{
				enemy.revive();
			}
		}
		
		for (enemy in enemiesType2)
		{
			if (InCameraBounds(enemy))
			{
				enemy.revive();
			}
		}
		
		for (enemy in enemiesType3)
		{
			if (InCameraBounds(enemy))
			{
				enemy.revive();
			}
		}
		
		for (enemy in enemiesType4)
		{
			if (InCameraBounds(enemy))
			{
				enemy.revive();
			}
		}
	}
	
	private function GameOver(victory:Bool):Void
	{
		FlxG.switchState(new GameOverState(victory));
	}
	
	private function RestartLevel():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	public function UpdateScore():Void
	{
		scoreText.text = "Score : " + Reg.score;
		if (Reg.score > Reg.highScore)
		{
			Reg.highScore = Reg.score;
			UpdateHighScore();
		}
	}
	
	public function UpdateHighScore():Void
	{
		highScoreText.text = "HighScore : " + Reg.highScore;
	}
	
	private function Collisions():Void
	{	
		FlxG.overlap(playerBullets, enemiesType1, null, CollsionHandler);
		FlxG.overlap(playerBullets, enemiesType2, null, CollsionHandler);
		FlxG.overlap(playerBullets, enemiesType3, null, CollsionHandler);
		FlxG.overlap(playerBullets, enemiesType4, null, CollsionHandler);
		FlxG.overlap(playerBullets, boss, null, CollsionHandler);
		FlxG.overlap(player, enemiesType1, null, CollsionHandler);
		FlxG.overlap(player, enemiesType2, null, CollsionHandler);
		FlxG.overlap(player, enemiesType3, null, CollsionHandler);
		FlxG.overlap(player, enemiesType4, null, CollsionHandler);
		FlxG.overlap(player, boss, null, CollsionHandler);
		FlxG.overlap(player, enemyBullets, null, CollsionHandler);
		FlxG.overlap(player, powerUps, null, CollsionHandler);
	}
	
	private function CollsionHandler(Sprite1:FlxObject, Sprite2:FlxObject):Bool
	{
		var sprite1ClassName:String = Type.getClassName(Type.getClass(Sprite1));
		var sprite2ClassName:String = Type.getClassName(Type.getClass(Sprite2));
		if (sprite1ClassName == "sprites.Player" &&
		(sprite2ClassName == "sprites.Ene1" || sprite2ClassName == "sprites.Ene2" ||
		sprite2ClassName == "sprites.Ene3" || sprite2ClassName == "sprites.Ene4" ||
		sprite2ClassName == "sprites.Boss"))
		{
			if (Reg.playerLives > 0)
			{
				Reg.playerLives--;
				RestartLevel();
			}
			else
			{
				GameOver(false);
			}

			return true;
		}
		
		if (sprite1ClassName == "sprites.Player" && sprite2ClassName == "sprites.Bullet")
		{			
			var bullet: Dynamic = cast(Sprite2, Bullet);
		
			if (player.shield == true)
			{
				enemyBullets.remove(bullet);
				player.SubstractShield();				
			}
			else
			{
				if (Reg.playerLives > 0)
				{
					Reg.playerLives--;
					RestartLevel();
				}
				else
				{
					GameOver(false);
				}
			}

			return true;
		}
		
		if (sprite1ClassName == "sprites.Bullet" && sprite2ClassName == "sprites.Ene1"){
			var bullet: Dynamic = cast(Sprite1, Bullet);
			var enemy: Dynamic = cast(Sprite2, Ene1);
			
			DropItem(enemy.x, enemy.y);			
			Reg.score += enemy.pointValue;
			UpdateScore();
			enemiesType1.remove(enemy);
			enemy.kill();
			playerBullets.remove(bullet);
			Sprite1.destroy();

			return true;
		}
		
		if (sprite1ClassName == "sprites.Bullet" && sprite2ClassName == "sprites.Ene2"){
			var bullet: Dynamic = cast(Sprite1, Bullet);
			var enemy: Dynamic = cast(Sprite2, Ene2);
			
			DropItem(enemy.x, enemy.y);			
			Reg.score += enemy.pointValue;
			UpdateScore();
			enemiesType2.remove(enemy);
			enemy.kill();
			playerBullets.remove(bullet);
			Sprite1.destroy();

			return true;
		}
		
		if (sprite1ClassName == "sprites.Bullet" && sprite2ClassName == "sprites.Ene3"){
			var bullet: Dynamic = cast(Sprite1, Bullet);
			var enemy: Dynamic = cast(Sprite2, Ene3);
			
			DropItem(enemy.x, enemy.y);
			Reg.score += enemy.pointValue;
			UpdateScore();
			enemiesType3.remove(enemy);
			enemy.kill();
			playerBullets.remove(bullet);
			Sprite1.destroy();

			return true;
		}

		if (sprite1ClassName == "sprites.Bullet" && sprite2ClassName == "sprites.Ene4"){
			var bullet: Dynamic = cast(Sprite1, Bullet);
			var enemy: Dynamic = cast(Sprite2, Ene4);
			
			DropItem(enemy.x, enemy.y);
			Reg.score += enemy.pointValue;
			UpdateScore();
			enemiesType4.remove(enemy);
			enemy.kill();
			playerBullets.remove(bullet);
			Sprite1.destroy();

			return true;
		}
		
		if (sprite1ClassName == "sprites.Bullet" && sprite2ClassName == "sprites.Boss"){
			var bullet: Dynamic = cast(Sprite1, Bullet);
			
			playerBullets.remove(bullet);
			Sprite1.destroy();
			boss.Damage();

			return true;
		}
		
		if (sprite1ClassName == "sprites.Player" && sprite2ClassName == "sprites.Item"){
			var powerUp: Dynamic = cast(Sprite2, Item);
			Reg.ub.SwitchUp();
			powerUps.remove(powerUp);
			powerUp.destroy();
			powerUpSound.play();
			return true;
		}
		
		return false;
	}
	
	private function DropItem(ex : Int, ey : Int)
	{
		var r : Float = Math.random();
		if (r < 0.3)
		{
			var it : Item = new Item(ex, ey);			
			powerUps.add(it);		
		}
	}
	
	private function PllayerStageCollision():Void
	{
		if (player.isTouching(FlxObject.ANY))
		{
			if (Reg.playerLives > 0)
			{
				Reg.playerLives--;
				RestartLevel();
			}
			else
			{
				GameOver(false);
			}
		}
	}
	
	private function PlayerMovementInCameraBounds():Void
	{
		var newScroll = FlxG.camera.scroll;

		if (player.x > newScroll.x + Reg.ScreenWidth - player.width)
		{
			player.x = newScroll.x + Reg.ScreenWidth - player.width;	
		}
		if (player.x < newScroll.x)
		{
			player.x = newScroll.x;
		}
		if (player.y > newScroll.y + Reg.ScreenHeight - player.height)
		{
			player.y = newScroll.y + Reg.ScreenHeight - player.height;	
		}
		if (player.y < newScroll.y)
		{
			player.y = newScroll.y;
		}
	}
	
	private function PlayerBulletsInCameraBounds():Void
	{
		var newScroll = FlxG.camera.scroll;
	
		for (bullet in playerBullets)
		{
			bullet.x += screenSpeed;

			if (bullet.isTouching(FlxObject.ANY) || !InCameraBounds(bullet))
			{
				playerBullets.remove(bullet);
				bullet.destroy();
			}
		}
	}
	
	private function EnemyBulletsInCameraBounds():Void
	{
		var newScroll = FlxG.camera.scroll;
	
		for (bullet in enemyBullets)
		{
			bullet.x += screenSpeed;

			if (bullet.isTouching(FlxObject.ANY) || !InCameraBounds(bullet))
			{
				enemyBullets.remove(bullet);
				bullet.destroy();
			}
		}
	}
	
	private function CameraMovement():Void
	{
		var newScroll = FlxG.camera.scroll;
		if (scroll){
			if (newScroll.x + 256 >= mapTiles.width)
			{
				scroll = false;
				boss.revive();
				add(boss.hpBar);		
				var hpBarText:FlxText = new FlxText(boss.x - 80, boss.y + 168, "BOSS");
				add(hpBarText);
			}
			else
			{
				newScroll.x += screenSpeed;
				FlxG.camera.scroll = newScroll;
				player.x += screenSpeed;
				scoreText.x += screenSpeed;
				highScoreText.x += screenSpeed;
				livesCounter.x += screenSpeed;
				Reg.ub.x += screenSpeed;
			}			
		}
	}
	
	private function EnemiesInCamera()
	{
		for (enemy in enemiesType1)
		{
			if (enemy.alive && !InCameraBounds(enemy))
			{
				enemiesType1.remove(enemy);
				enemy.kill();
			}
		}
		
		for (enemy in enemiesType2)
		{
			if (enemy.alive && !InCameraBounds(enemy))
			{
				enemiesType2.remove(enemy);
				enemy.kill();
			}
		}
		
		for (enemy in enemiesType3)
		{
			if (enemy.alive && !InCameraBounds(enemy))
			{
				enemiesType3.remove(enemy);
				enemy.kill();
			}
		}
		
		for (enemy in enemiesType4)
		{
			if (enemy.alive && !InCameraBounds(enemy))
			{
				enemiesType4.remove(enemy);
				enemy.kill();
			}
		}
	}
	
	private function InCameraBounds(sprite:FlxSprite):Bool
	{
		var newScroll = FlxG.camera.scroll;

		if (sprite.x > newScroll.x + Reg.ScreenWidth + 16)
		{
			return false;
		}
		if (sprite.x < newScroll.x - 16)
		{
			return false;
		}
		if (sprite.y + sprite.height > newScroll.y + Reg.ScreenHeight)
		{
			return false;
		}
		if (sprite.y < newScroll.y)
		{
			return false;
		}
		return true;
	}
	
	private function drawEntities( entityName:String, entityData:Xml):Void
	{
		if (entityName == "player")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			playerBullets = new FlxTypedGroup<Bullet>();		
			add(playerBullets);
			
			player = new Player(X, Y, playerBullets);
			player.velocity.x = 0.01;
			add(player);
		}

		if (entityName == "enemy1")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			var enemy:Ene1;
			enemy = new Ene1(X, Y);
			enemy.kill();
			enemiesType1.add(enemy);
		}
		
		if (entityName == "enemy2")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			var enemy:Ene2;
			enemy = new Ene2(X, Y, enemyBullets);
			enemy.kill();
			enemiesType2.add(enemy);
		}
		
		if (entityName == "enemy3")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			var enemy:Ene3;
			enemy = new Ene3(X, Y, enemyBullets);
			enemy.kill();
			enemiesType3.add(enemy);
		}
		
		if (entityName == "enemy4")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			var enemy:Ene4;
			enemy = new Ene4(X, Y, enemyBullets);
			enemy.kill();
			enemiesType4.add(enemy);
		}
		
		if (entityName == "boss")
		{
			var X:Float = Std.parseFloat(entityData.get("x"));
			var Y:Float = Std.parseFloat(entityData.get("y"));
			
			boss = new Boss(X, Y, enemyBullets);
			boss.kill();
			add(boss);
		}
	}
}

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
import sprites.Bullet;
import sprites.Player;
import sprites.Ene1;
import sprites.Ene2;
import sprites.Ene3;//Test


class PlayState extends FlxState
{
	private var level:FlxTilemap;
	private var player:Player;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var enemyBullets:FlxTypedGroup<Bullet>;
	public var enemiesType1:FlxTypedGroup<Ene1>;
	public var screenPositionX:Float = 0;
	public var screenSpeed:Float = 1;
	public var scroll:Bool = true;
	private var scoreText:FlxText;
	private var highScoreText:FlxText;
	private var livesCounter:FlxText;
	
	private var ene : Ene3;//Test
	
	override public function create():Void
	{
		super.create();

		enemiesType1 = new FlxTypedGroup<Ene1>();
		add(enemiesType1);
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level1__oel);
		level = loader.loadTilemap(AssetPaths.tileset__png , 16, 16, "tiles");
		loader.loadEntities(drawEntities, "entities");
		
		FlxG.camera.setScrollBounds(0, level.width, 0, level.height);
		FlxG.camera.scroll = new FlxPoint(0,0);
		scroll = true;
		
		FlxG.worldBounds.set(0, 0, level.width, level.height);
		
		level.setTileProperties(0, FlxObject.NONE);
		level.setTileProperties(1, FlxObject.ANY);
		level.setTileProperties(2, FlxObject.NONE);
		add(level);
		
		scoreText = new FlxText(90, Reg.ScreenHeight - 20, "Score : " + Reg.score);
		add(scoreText);
		highScoreText = new FlxText(150, Reg.ScreenHeight - 20, "HighScore : " + Reg.highScore);
		add(highScoreText);
		livesCounter = new FlxText(10, Reg.ScreenHeight - 20, "Lives : " + Reg.playerLives);
		add(livesCounter);
		
		//enemyBullets = new FlxTypedGroup<Bullet>();		
		//add(enemyBullets);
	}
	
	private var time : Int = 0; //Test
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(level, player);
		FlxG.collide(level, playerBullets);
		FlxG.collide(level, enemyBullets);
		FlxG.collide(level, enemyBullets);

		if (player.alive)
		{
			CameraMovement();
			PlayerMovementInCameraBounds();
			PlayerBulletsInCameraBounds();
			//EnemyBulletsInCameraBounds();
			PllayerStageCollision();	
			ActivateEnemies();
			//PllayerEnemyCollision();	
		}				
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
	}
	
	private function GameOver():Void
	{
		FlxG.switchState(new GameOverState());
	}
	
	private function RestartLevel():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	public function UpdateScore():Void
	{
		scoreText.text = "Score : " + Reg.score;
	}
	
	public function UpdateHighScore():Void
	{
		highScoreText.text = "HighScore : " + Reg.highScore;
	}
	
	private function PllayerEnemyCollision():Void
	{
		if (FlxG.overlap(enemyBullets, player))
		{
			if (Reg.playerLives > 0)
			{
				Reg.playerLives--;
				RestartLevel();
			}
			else
			{
				GameOver();
			}
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
				GameOver();
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

			if (bullet.isTouching(FlxObject.ANY) ||
			(bullet.x > (newScroll.x + Reg.ScreenWidth)))
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

			if (bullet.isTouching(FlxObject.ANY) ||
			(bullet.x > (newScroll.x + Reg.ScreenWidth)) ||
			bullet.x < (newScroll.x))
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
			if (newScroll.x + 256 >= level.width)
			{
				scroll = false;
			}
			else
			{
				newScroll.x += screenSpeed;
				FlxG.camera.scroll = newScroll;
				player.x += screenSpeed;
				scoreText.x += screenSpeed;
				highScoreText.x += screenSpeed;
				livesCounter.x += screenSpeed;
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
			player.makeGraphic(16, 16, 0xFF00FF00);
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
	}
}

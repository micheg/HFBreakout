package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import Levels; // Importiamo i livelli

class LevelFactory
{
    public static function createBricks(levelIndex:Int = 0):FlxTypedGroup<FlxSprite>
    {
        var _grpBricks = new FlxTypedGroup<FlxSprite>();

        if (levelIndex < 0 || levelIndex >= Levels.LEVELS.length)
        {
            trace("Errore: Livello fuori range! Carico il primo livello.");
            levelIndex = 0;
        }

        var level = Levels.LEVELS[levelIndex];

        var brickWidth:Int = 80;
        var brickHeight:Int = 32;

        var numCols = level[0].length;
        var numRows = level.length;

        // Calcoliamo l'offset per centrare il livello sullo schermo
        var totalWidth = numCols * brickWidth;
        var startX = (FlxG.width - totalWidth) / 2;
        var startY = 64; // Altezza iniziale

        for (row in 0...numRows)
        {
            for (col in 0...numCols)
            {
                var brickType = level[row][col];

                if (brickType > 0) // Se non è uno spazio vuoto
                {
                    var b = new FlxSprite(startX + col * brickWidth, startY + row * brickHeight, AssetPaths.brick__png);
                    b.immovable = true;
                    b.color = Levels.COLORS.get(brickType);
                    _grpBricks.add(b);
                }
            }
        }
        return _grpBricks;
    }
}

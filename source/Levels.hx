package;

import flixel.util.FlxColor;

class Levels
{
    public static var LEVELS:Array<Array<Array<Int>>> = [
        // Livello 1
        [
            [1, 2, 3, 4, 5, 1],
            [1, 0, 2, 0, 3, 4],
            [4, 3, 2, 1, 5, 0],
            [5, 4, 3, 2, 1, 5]
        ],
        
        // Livello 2 - Più largo
        [
            [1, 2, 3, 4, 5, 1, 2, 3],
            [2, 0, 4, 0, 3, 4, 5, 1],
            [4, 3, 2, 1, 5, 0, 2, 4],
            [5, 4, 3, 2, 1, 5, 4, 3]
        ],

        // Livello 3 - Più stretto e alto
        [
            [1, 2, 3, 4],
            [2, 3, 4, 5],
            [3, 4, 5, 1],
            [4, 5, 1, 2],
            [5, 1, 2, 3],
            [1, 2, 3, 4]
        ]
    ];

    // Mappa colori per i mattoni
    public static var COLORS:Map<Int, FlxColor> = [
        1 => FlxColor.RED,
        2 => FlxColor.BLUE,
        3 => FlxColor.GREEN,
        4 => FlxColor.YELLOW,
        5 => FlxColor.PURPLE
    ];
}

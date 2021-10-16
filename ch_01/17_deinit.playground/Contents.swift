// Deinitialization
// 해제

var a: Int? = 10
// 여기서 해지되는데, 필요에 따라 메모리에서 완전히 해지된다.
a = nil

class Round {
    // 이 때 weak는 참조의 권한이 없고,
    // 해당 game을 참조하고 있던 변수가 참조를 풀면 사라진다.
    weak var gameInfo: Game?
    var lastRound = 10
    var roundTime = 20
    
    // 이런경우는 있어서는 안된다.
    weak var weakGame: Game? = Game()
    
    init() {
     print("round init")
    }
    
    deinit {
        // 해지될 때, 발생
        // 로그를 보내는 등으로 사용됨
        print("round deinit")
    }
}

class Game {
    var score = 0
    var name = ""
    weak var round: Round?
    
    init() {
     print("game init")
    }
    
    deinit {
        // 해지될 때, 발생
        // 로그를 보내는 등으로 사용됨
        print("game deinit")
    }
}

var game: Game? = Game()
var round: Round? = Round()


// 서로가 서로를 참조하는 상황
// 때문에 game에 nil을 줘도 해지가 안된다.
round?.gameInfo = game
game?.round = round

game = nil
// round?.gameInfo = nil
// 이게 있어야 한다. 이런경우에는
round = nil
// 이런경우 티가 안난다.

import Vapor

// controls logic of guessing game
final class GameController {
    
    func isInteger(_ integer: Any) -> Int? {
        guard let number = integer as? Int else { return nil}
        return number
    }
    
    func welcome(_ req: Request) throws -> Future<View> {
        let game = GameState()
        let data = game.save(on: req)
        return try req.view().render("Welcome", data)
    }
    
    func renderHost(_ req: Request) throws -> Future<View> {
        print("In renderHost")
        return try req.parameters.next(GameState.self).flatMap { game in
            return try req.view().render("host", game)
        }
        
    }
    
    func guess(_ req: Request) throws -> Future<Response> {
        let params = req.parameters.values
        print(params.map { $0 })
        print("In guess")
        return try req.parameters.next(GameState.self).flatMap { game in
            return try req.content.decode(GameForm.self).flatMap { gameForm in
                if game.numberToGuess != Int(gameForm.numberToGuess) {
                    game.remainingGuesses -= 1
                    return game.save(on: req).map {_ in
                        return req.redirect(to: "/host/\(game.id!)/guessing-game")
                    }
                }
                
                return game.delete(on: req).map {_ in
                        return req.redirect(to: "/youwin")

                }
            }
        }
    }
    
    func youWin(_ req: Request) throws -> Future<View> {
        return try req.view().render("youwin")
    }
    
}

// For creating random strings to identify gamestate before id is available
extension String {
    static func randomString(length: Int) -> String {
        var randString = ""
        for _ in 1...length {
            randString.append(String(UnicodeScalar(Int.random(in: 48..<58))!))
        }
        
        return randString
    }
}

extension Int {
    static func random(in range: Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
}

struct GameForm: Content {
    var numberToGuess: String
}


import Vapor

// controls logic of guessing game
final class GameController {
    
    func isInteger(_ integer: Any) -> Int? {
        guard let number = integer as? Int else { return nil}
        return number
    }
    
    
    func renderHost(_ req: Request) throws -> Future<View> {
        return try req.view().render("host")
    }
    
    func renderLogin(_ req: Request) throws -> Future<View> {
        return try req.view().render("login")
    }
    
    func newGame(_ req: Request) throws -> Future<View> {
        let game = GameState().save(on: req)
        return try req.view().render("host", game )
        
        // TODO: have this render then redirect somewhere else so refreshes don't keep adding games.
    }
    
}

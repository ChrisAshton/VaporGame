import Vapor

// controls logic of guessing game
final class GameController {
    
    func renderHost(_ req: Request) throws -> Future<View> {
        return try req.view().render("guessingGame")
    }
    
    func renderLogin(_ req: Request) throws -> Future<View> {
        return try req.view().render("login")
    }
}

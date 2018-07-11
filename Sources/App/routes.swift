import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Game routes
    let controller = GameController()
    
    router.get("guessing-game" , use: controller.welcome)
    router.get("youwin", use: controller.youWin)
    router.get("host", GameState.parameter, "guessing-game", use: controller.renderHost)
    
    router.post("host", GameState.parameter, "guessing-game", use: controller.renderHost)
    router.post("guess", GameState.parameter, use: controller.guess)
    
    



    
    router.get("look") { req -> Future<[GameState]> in
        return GameState.query(on: req).all()
    }
    
    
   // router.post("users", User.parameter, "update", use: userController.update)
    
}

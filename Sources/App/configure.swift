import FluentSQLite
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register LeafProvider
    try services.register(LeafProvider())
    
    // boilerplate to set leafprovider as preferred ViewRenderer
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    // Initiate database service
    var databases = DatabasesConfig()
    try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
    services.register(databases)
    
    // Register migration service to introduce model to database
    var migrations = MigrationConfig()
    migrations.add(model: GameState.self, database: .sqlite) // adding things to migrations...
    services.register(migrations)
}

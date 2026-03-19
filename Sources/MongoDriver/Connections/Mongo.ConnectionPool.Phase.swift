extension Mongo.ConnectionPool {
    /// The current stage of a connection pool’s lifecycle.
    enum Phase: Sendable {
        /// The connection pool is active and can create new connections.
        case connecting(Mongo.Connector<Mongo.Authenticator>)
        /// The connection pool is inactive and cannot create new connections.
        case draining(Mongo.ConnectionPoolDrainedError)
    }
}

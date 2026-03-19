extension Mongo {
    protocol Instant: Sendable {
        static func < (lhs: Self, rhs: Self) -> Bool
    }
}
extension Mongo.Instant {
    func combined(with other: Self?) -> Self {
        guard let other: Self else {
            return self
        }
        if  other < self {
            return self
        } else {
            return other
        }
    }
    func combine(into value: inout Self?) {
        value = self.combined(with: value)
    }
}

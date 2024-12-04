import Algorithms

struct Day01: AdventDay {
    var data: String

    var entities: ([Int], [Int]) {
        let lines = data.components(separatedBy: .newlines).compactMap { line -> (Int, Int)? in
            let parts = line.split(separator: "   ")
            guard parts.count == 2, let left = Int(parts[0]), let right = Int(parts[1]) else { return nil }
            return (left, right)
        }

        let lefts: [Int] = lines.map { $0.0 }.sorted()
        let rights: [Int] = lines.map { $0.1 }.sorted()

        return (lefts, rights)
    }

    func part1() -> Any {
        let lefts = entities.0
        let rights = entities.1
        return zip(lefts, rights).reduce(0) { $0 + abs($1.0 - $1.1) }
    }

    func part2() -> Any {
        // Sum the maximum entries in each set of data
        let lefts = entities.0
        let rights = entities.1
        return lefts
            .map { left in
                left * rights.count(where: { $0 == left })
            }
            .reduce(0, +)
    }
}

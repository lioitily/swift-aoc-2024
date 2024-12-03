import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
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

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let lefts = entities.0
        let rights = entities.1
        return zip(lefts, rights).reduce(0) { $0 + abs($1.0 - $1.1) }
    }

    // Replace this with your solution for the second part of the day's challenge.
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

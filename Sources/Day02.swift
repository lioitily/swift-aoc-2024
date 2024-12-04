import Algorithms

struct Day02: AdventDay {
  var data: String

  var lines: [[Int]] {
    data.components(separatedBy: .newlines).compactMap {
      $0.components(separatedBy: .whitespaces).compactMap(Int.init)
    }
  }

  func isSafe(for line: [Int]) -> Bool {
    guard line.count > 1 else {
      return false
    }

    let pairs = line.adjacentPairs().map { $0.0 - $0.1 }
    let isPositive = pairs[0].signum() >= 0
    let validRange = isPositive ? (1 ... 3) : (-3 ... -1)

    return pairs.allSatisfy { p in
      validRange.contains(p)
    }
  }

  func part1() -> Any {
    return lines.count(where: isSafe(for:))
  }

  func part2() -> Any {
    func remove(for line: [Int]) -> Bool {
      for i in 0 ..< line.count {
        var copy = line
        copy.remove(at: i)
        if isSafe(for: copy) {
          return true
        }
      }
      return false
    }
    return lines.count { line in
      isSafe(for: line) || remove(for: line)
    }
  }
}

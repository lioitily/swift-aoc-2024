import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  func muls(_ data: String) -> [(x: Int, y: Int)] {
    let regex = /mul\((\d+),(\d+)\)/
    let matchs = data.matches(of: regex)
    return matchs.compactMap { match in
      guard let x = Int(match.1), let y = Int(match.2) else { return nil }
      return (x, y)
    }
  }

  func mul(_ x: Int, _ y: Int) -> Int {
    x * y
  }

  func part1() -> Any {
    return muls(data).map(mul).reduce(0, +)
  }

  func part2() -> Any {
    let pattern = /don't\(\).*?(?:do\(\)|$)/
    let data = data.replacing("\n", with: "")
      .replacing(pattern, with: "")
    return muls(data).map(mul).reduce(0, +)
  }
}

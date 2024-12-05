import Algorithms

struct Day05: AdventDay {
  var data: String

  private var input: (rules: [String], pages: [[Int]]) {
    let parts = data.components(separatedBy: "\n\n")
    guard parts.count == 2 else { fatalError() }

    let rules = parts[0]
      .components(separatedBy: .newlines)

    let pages = parts[1]
      .components(separatedBy: .newlines)
      .map { $0.split(separator: ",").compactMap { Int($0) } }

    return (rules, pages)
  }

  private func validPage(_ page: [Int], rules: [String]) -> Bool {
    guard page.count > 1 else { return false }
    let pairs = page.adjacentPairs()
    return pairs.allSatisfy { rules.contains("\($0.0)|\($0.1)") }
  }

  func part1() -> Any {
    let (rules, pages) = input
    return pages.filter { validPage($0, rules: rules) }
      .compactMap { Int($0[$0.count / 2]) }
      .reduce(0, +)
  }

  func part2() -> Any {
    let (rules, pages) = input
    return pages.filter { !validPage($0, rules: rules) }
      .compactMap { page -> [Int]? in
        let sorted = page.sorted { rules.contains("\($0)|\($1)") }
        return validPage(sorted, rules: rules) ? sorted : nil
      }
      .compactMap { Int($0[$0.count / 2]) }
      .reduce(0, +)
  }
}

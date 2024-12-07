import Algorithms

struct Day07: AdventDay {
  var data: String

  private var input: [(expect: Int, numbers: [Int])] {
    let lines = data.components(separatedBy: .newlines)
    return lines.compactMap { line -> (expect: Int, numbers: [Int])? in
      let parts = line.split(separator: ":")
      guard parts.count == 2, let expect = Int(parts[0]) else { return nil }
      let numbers = parts[1].split(separator: " ").compactMap({ Int($0) })
      return (expect, numbers)
    }
  }

  private func cal(
    expect: Int,
    numbers: [Int],
    partial: (result: Int?, index: Int),
    ops: [String]
  ) -> Int? {
    let nextIndex = partial.index + 1
    guard let current = partial.result, nextIndex < numbers.count else {
      return partial.result == expect ? partial.result : nil
    }
    let next = numbers[nextIndex]
    for op in ops {
      let nextVal = switch op {
        case "+":
          current + next
        case "*":
          current * next
        case "||":
          Int("\(current)\(next)") ?? current
        default:
          current
      }
      if let r = cal(expect: expect, numbers: numbers, partial: (nextVal, nextIndex), ops: ops) {
        return r
      }
    }
    return nil
  }

  func part1() -> Any {
    return input
      .compactMap {
        cal(expect: $0.expect, numbers: $0.numbers, partial: ($0.numbers.first, 0), ops: ["+", "*"])
      }
      .reduce(0, +)
  }

  func part2() -> Any {
    return input
      .compactMap {
        cal(expect: $0.expect, numbers: $0.numbers, partial: ($0.numbers.first, 0), ops: ["+", "*", "||"])
      }
      .reduce(0, +)
  }

}

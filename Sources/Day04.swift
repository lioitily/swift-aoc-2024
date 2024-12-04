import Algorithms

struct Day04: AdventDay {
  struct Point: Hashable {
    let x, y: Int

    func neighbor(direction: Direction, steps: Int = 1) -> Point {
      switch direction {
      case .bottom:
        return Point(x: x, y: y + steps)
      case .bottomLeft:
        return Point(x: x - steps, y: y + steps)
      case .bottomRight:
        return Point(x: x + steps, y: y + steps)
      case .top:
        return Point(x: x, y: y - steps)
      case .topLeft:
        return Point(x: x - steps, y: y - steps)
      case .topRight:
        return Point(x: x + steps, y: y - steps)
      case .left:
        return Point(x: x - steps, y: y)
      case .right:
        return Point(x: x + steps, y: y)
      }
    }
  }

  enum Direction: CaseIterable {
    case top, topLeft, topRight
    case bottom, bottomLeft, bottomRight
    case left, right
  }

  var data: String

  private var points: [Point: String] {
    let lines: [String] = data.components(separatedBy: .newlines)
    var points: [Point: String] = [:]
    for (y, line) in lines.enumerated() {
      for (x, char) in line.enumerated() {
        points[Point(x: x, y: y)] = String(char)
      }
    }
    return points
  }

  private func getXMASCount(for point: Point, points: [Point: String]) -> Int {
    guard let p = points[point] else { return 0 }
    guard "XS".contains(p) else { return 0 }

    let xmas = "XMAS"
    let directions: [Direction] = [.right, .bottom, .bottomLeft, .bottomRight]
    return directions.map { d -> String in
      (0 ..< xmas.count)
        .compactMap { points[point.neighbor(direction: d, steps: $0)] }
        .joined()
    }
    .filter { $0 == xmas || $0 == String(xmas.reversed()) }
    .count
  }

  func part1() -> Any {
    let points = self.points
    return points.keys.reduce(0, {
      $0 + getXMASCount(for: $1, points: points)
    })
  }

  private func getMASCount(for point: Point, points: [Point: String]) -> Int {
    guard let p = points[point] else { return 0 }
    guard "A".contains(p) else { return 0 }

    let topLeft = points[point.neighbor(direction: .topLeft)] ?? ""
    let topRight = points[point.neighbor(direction: .topRight)] ?? ""
    let bottomLeft = points[point.neighbor(direction: .bottomLeft)] ?? ""
    let bottomRight = points[point.neighbor(direction: .bottomRight)] ?? ""

    return [
      [topLeft, bottomRight].sorted().joined(),
      [topRight, bottomLeft].sorted().joined()
    ].allSatisfy { $0 == "MS" } ? 1 : 0
  }

  func part2() -> Any {
    let points = self.points
    return points.keys.reduce(0, {
      $0 + getMASCount(for: $1, points: points)
    })
  }
}
